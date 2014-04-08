class Subscription < ActiveRecord::Base

	belongs_to :company
	belongs_to :plan

	attr_accessible :billing_period,:company_id,:plan_id,:last_payment_at

	validates :billing_period, presence: true
	validates :company_id, presence: true,uniqueness: {message: "already has a subscription plan."}

	def plans
		Plan.pluck(:name,:id)
	end

end
