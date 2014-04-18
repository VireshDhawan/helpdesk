module SubscriptionsHelper

	def authorize_subscription_privilages_in_view
		current_agent.allow_subscription_management ? true : false
	end

end
