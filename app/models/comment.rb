class Comment < ActiveRecord::Base

	belongs_to :ticket
	belongs_to :agent

#	after_create :new_comment_notify
	
	attr_accessible :content,:agent_id,:ticket_id
	validates :content, presence: true
	
	def new_comment_notify
		# notify all of new comment if applicable
		recipients = self.ticket.company.agents.select {|a| a.notification.all_comments?}.map(&:email)
		Mailer.delay(queue: "helpdesk_notification_queue").new_comment_notification(self.ticket,self,recipients) unless recipients.blank?

		#notify all agents belonging to a group
		recipients = self.ticket.company.agents.select {|a| a.notification.comments_on_my_group_tickets? && a.groups.include?(self.ticket.group)}.map(&:email)
		Mailer.delay(queue: "helpdesk_notification_queue").new_comment_notification(self.ticket,self,recipients) unless recipients.blank?

		#notify if a agent participated in a ticket
		if self.agent.blank?
			recipients = self.ticket.comments.select {|c| !c.agent.blank?}.map {|c| c.agent.email}
			Mailer.delay(queue: "helpdesk_notification_queue").new_comment_notification(self.ticket,self,recipients) unless recipients.blank?
		end
	end

	def class?
		return "Comment"
	end

end
