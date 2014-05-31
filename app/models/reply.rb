class Reply < ActiveRecord::Base

	belongs_to :ticket
	belongs_to :agent

#	after_create :new_reply_notify
	before_create :set_replier_name

	attr_accessible :content,:agent_id,:ticket_id,:replier_name,:company_id
	validates :content, presence: true

	def new_reply_notify
		# notify all of new reply if applicable
		recipients = self.ticket.company.agents.select {|a| a.notification.reply_all?}.map(&:email)
		Mailer.delay(queue: "helpdesk_notification_queue").new_reply_notification(self.ticket,self,recipients) unless recipients.blank?

		#notify all agents belonging to a group
		recipients = self.ticket.company.agents.select {|a| a.notification.reply_on_my_group_tickets? && a.groups.include?(self.ticket.group)}.map(&:email)
		Mailer.delay(queue: "helpdesk_notification_queue").new_reply_notification(self.ticket,self,recipients) unless recipients.blank?

		#notify if a agent participated in a ticket
		if self.agent.blank?
			recipients = self.ticket.replies.select {|r| !r.agent.blank?}.map {|r| r.agent.email}
			Mailer.delay(queue: "helpdesk_notification_queue").new_reply_notification(self.ticket,self,recipients) unless recipients.blank?
		else
			Mailer.delay(queue: "helpdesk_notification_queue").new_reply_notification(self.ticket,self,self.ticket.customer_email) unless self.ticket.customer_email.blank?
		end
	end

	def set_replier_name
		if self.agent_id.blank?
			self.replier_name = self.ticket.customer_name
		else
			self.replier_name = self.agent.full_name
		end
	end

	# To find count of tickets grouped by category,date
	def self.in_date_range_for_replies(date1,date2,company)
		hash = company.replies.where("created_at >= ? AND created_at <=?", date1,date2).order('DATE(created_at) DESC').group("DATE(created_at)").count
		hash1 = Hash[(date1..date2).collect { |v| [DateTime.parse(v.to_s).strftime("%Q").to_i, 0] }]
		hash = Hash[hash.map{|k,v| [DateTime.parse(k.to_s).strftime('%Q').to_i,v]}]
		hash = hash1.merge(hash).to_a
	end

	def class?
		return "Reply"
	end

end
