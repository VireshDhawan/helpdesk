class ForwardingAddress < ActiveRecord::Base

	belongs_to :company
	before_create :create_forwarding_address

	attr_accessible :from,:to,:alias_name,:bcc_to,:spam_filter,
					:use_agents_name,:company_id

	validates_presence_of :from
	validates_format_of :from, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

	def create_forwarding_address
		self.to = SecureRandom.hex(13) + "@sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org" 
	end

end
