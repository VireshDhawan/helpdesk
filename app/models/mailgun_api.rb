class MailgunApi < ActiveRecord::Base

	attr_accessible :key

	validates :kay, presence: true,uniqueness: true

end
