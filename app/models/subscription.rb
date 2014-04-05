class Subscription < ActiveRecord::Base

	belongs_to :company
	
	attr_accessible :billing_period,:plan,:company_id

	validates :billing_period, presence: true
	validates :plan, presence: true
	validates :company_id, presence: true,uniqueness: {message: "already has a subscription plan."}

	def plans
		[
			"Starter","Startups","Small","Medium","Large","Enterprise"
		]
	end

end
