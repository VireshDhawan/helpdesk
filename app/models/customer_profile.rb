class CustomerProfile < ActiveRecord::Base

	belongs_to :company
	has_many :customer_profile_emails
	has_many :tickets
	has_many :replies,as: :replier

	attr_accessible :name,:company_id

	validates_presence_of :company_id

end
