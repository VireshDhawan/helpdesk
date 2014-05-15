class ForwardingAddress < ActiveRecord::Base

	belongs_to :company
	before_create :create_forwarding_address
	after_create :create_route_for_address
	before_destroy :delete_forwarding_address

	attr_accessible :from,:to,:alias_name,:bcc_to,:spam_filter,
					:use_agents_name,:company_id

	validates_presence_of :from
	validates_uniqueness_of :to
	validates_format_of :from, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
	validate :validate_forwarding_address_count

	private

	def create_forwarding_address
		username = SecureRandom.hex(13)
		self.to =  username + "@sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org"
		MailgunTasks.create_credentials(username,username.reverse)
	end

	def create_route_for_address
		MailgunTasks.create_route(self.to)
	end

	## delete the forwarding address from mailgun on delete
	def delete_forwarding_address
		MailgunTasks.delete_credentials(self.to.split("@")[0])
	end

	def self.get_company_of_address(address)
		ForwardingAddress.find_by(to: address).company
	end

	def self.get_reply_email(address)
		ForwardingAddress.find_by(to: address).from
	end

	## restrict no of emails according to the plan
	def validate_forwarding_address_count
		company = self.company
		plan = company.subscription.plan
		puts company.forwarding_addresses.count , plan.emails
		if company.forwarding_addresses.count == plan.emails || company.forwarding_addresses.count > plan.emails
			errors.add(:base, 'Max email address limit reached. Please upgrade your plan.')
		end
	end

end