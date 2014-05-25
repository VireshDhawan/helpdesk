module SubscriptionsHelper

	def authorize_subscription_privilages_in_view
		current_agent.allow_subscription_management ? true : false
	end

	def plan_limit(value)
		(value == -1) ? "Unlimited" : value
	end

end
