class Ticket < ActiveRecord::Base

	belongs_to :agent
	belongs_to :company
	belongs_to :group
	belongs_to :ticket_category
	has_and_belongs_to_many :labels
	has_many :replies
	has_many :comments

	attr_accessible :customer_name,:customer_email,:subject,:message,:reply_email,
					:agent_id,:group_id,:company_id,:ticket_category_id,:notify_customer,
					:cc,:answered

	validates_presence_of :customer_email,:subject,:message,:reply_email

	scope :in_category, ->(category) do
		type = TicketCategory.find_by(name: category)
		select{ |t| t.ticket_category == type }
	end

	# To find count of tickets grouped by category,date
	def self.in_date_range_with_count(date1,date2,category,company)
		unless category.blank?
			type = TicketCategory.find_by(name: category)
			hash = company.tickets.where("created_at >= ? AND created_at <=? AND ticket_category_id = ?", date1,date2,type.id).group("DATE(created_at)").count
		else
			hash = company.tickets.where("created_at >= ? AND created_at <=?", date1,date2).group("DATE(created_at)").count
		end
		#hash1 = (date1..date2).map {|a| {DateTime.parse(a.to_s).strftime("%Q") => 0}}.reduce(Hash.new,:merge)
		hash1 = Hash[(date1..date2).collect { |v| [DateTime.parse(v.to_s).strftime("%Q").to_i, 0] }]
		hash = Hash[hash.map{|k,v| [DateTime.parse(k.to_s).strftime("%Q").to_i,v]}]
		hash = hash1.merge(hash).to_a
	end

	def status?
		self.answered? ? "Answered" : "Unanswered"
	end

	def assigned?
		self.agent ? self.agent.full_name : nil
	end

	def category
		self.ticket_category ? self.ticket_category.name : nil
	end

	def add_labels(labels)
		self.labels << labels
		self.save
	end

	def mark_answered
		self.answered = true
		self.save
	end

	def mark_unanswered
		self.answered = false
		self.save
	end

	def assign_to_agent(agent)
		self.agent = agent
		self.save
		Mailer.delay(queue: "helpdesk_notification_queue").ticket_assigned_to_agent(agent,self) if agent.notification.assigned_tickets?
	end

	def assign_to_group(group)
		self.group = group
		self.save
		recipients = group.agents.select {|a| a.notification.assigned_group?}.map(&:email)
		Mailer.delay(queue: "helpdesk_notification_queue").ticket_assigned_to_group(group,self,recipients) unless recipients.blank?
	end

	def mark_unassigned
		self.ticket_category = TicketCategory.find_by(name: "Unassigned")
		self.save
		recipients = self.company.agents.select {|a| a.notification.unassigned_tickets?}.map(&:email)
		Mailer.delay(queue: "helpdesk_notification_queue").unassigned_tickets_notification(self,recipients) unless recipients.blank?
	end

	def add_to_archive
		self.ticket_category = TicketCategory.find_by(name: "Archived")
		self.save
	end

	def add_to_spam
		self.ticket_category = TicketCategory.find_by(name: "Spam")
		self.save
	end

	def move_to_trash
		self.ticket_category = TicketCategory.find_by(name: "Trash")
		self.save
	end

	def add_filter(filter)
		self.assign_to_agent(filter.agent) unless filter.agent.blank?
		self.assign_to_group(filter.group) unless filter.group.blank?
		self.add_labels(filter.label) unless filter.label.blank?
		self.add_to_archive unless filter.archive.blank?
		self.add_to_trash unless filter.trash.blank?
		self.add_to_spam unless filter.spam.blank?
	end
	
end
