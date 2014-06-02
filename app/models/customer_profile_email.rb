class CustomerProfileEmail < ActiveRecord::Base

	belongs_to :customer_profile

	attr_accessible :email,:customer_profile_id

	validates :customer_profile_id,:presence => true,uniqueness: true
	validates :email, presence: true, uniqueness: {scope: :customer_profile_id, message: "Email already exist for this profile."},format: { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i }
	
end
