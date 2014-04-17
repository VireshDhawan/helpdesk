class Ticket < ActiveRecord::Base

	belongs_to :agent
	belongs_to :company
	belongs_to :group
	belongs_to :ticket_category
	has_and_belongs_to_many :labels

	attr_accessible :customer_name,:customer_email,:subject,:message,:reply_email,
					:agent_id,:group_id,:company_id,:ticket_category_id

#	validates_presence_of :customer_name,:customer_email,:subject,:message,:reply_email,
#						  :agent_id,:company_id

end
