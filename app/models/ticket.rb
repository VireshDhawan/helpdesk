class Ticket < ActiveRecord::Base

	belongs_to :agent
	belongs_to :company
	belongs_to :group

	attr_accessible :customer_name,:customer_email,:subject,:message,:reply_email,
					:agent_id,:group_id,:company_id

#	validates_presence_of :customer_name,:customer_email,:subject,:message,:reply_email,
#						  :agent_id,:company_id

end
