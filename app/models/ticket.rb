class Ticket < ActiveRecord::Base

	belongs_to :agent
	belongs_to :company
	belongs_to :group
	belongs_to :ticket_category
	has_and_belongs_to_many :labels

	attr_accessible :customer_name,:customer_email,:subject,:message,:reply_email,
					:agent_id,:group_id,:company_id,:ticket_category_id,:notify_customer,
					:cc,:answered

	validates_presence_of :customer_email,:subject,:message,:reply_email

	def add_labels(labels)
		self.labels = ticket.labels + labels
		self.save
	end

	def mark_answered
		self.ticket_category = TicketCategory.find_by(name: "Answered")
		self.save
	end

	def assign_to_agent(agent)
		self.agent = agent
		self.save
	end

	def assign_to_group(group)
		self.group = group
		self.save
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
