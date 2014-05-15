class MailgunApi < ActiveRecord::Base

	attr_accessible :private_key,:public_key

	validates :private_key, presence: true,uniqueness: true
	validates :public_key, presence: true,uniqueness: true

end
