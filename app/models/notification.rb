class Notification < ActiveRecord::Base

	belongs_to :agent

	attr_accessible :unassigned_tickets,:assigned_tickets,:assigned_group,
					:reply_all,:reply_on_my_tickets,:reply_on_my_group_tickets,
					:all_comments,:comments_on_my_tickets,:comments_on_my_group_tickets,
					:agent_id

	validates_presence_of 	:unassigned_tickets,:assigned_tickets,:assigned_group,
							:reply_all,:reply_on_my_tickets,:reply_on_my_group_tickets,
							:all_comments,:comments_on_my_tickets,:comments_on_my_group_tickets, :allow_blank => true
	
	
end
