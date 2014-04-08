class InvitationsController < Devise::InvitationsController

	prepend_before_filter :has_subscription, only: [:new,:create,:destroy]
	prepend_before_filter :require_company
	prepend_before_filter :if_admin, only: [:new,:create,:destroy]

	private

	def invite_resource
	## skip sending emails on invite
		resource_class.invite!(invite_params, current_inviter)
	end

	def after_accept_path_for(resource)
		edit_agent_registration_path
	end

	def if_admin
		if current_agent
			#check if admin
			authorize
		else
			flash[:error] = "You need to sign in before continuing"
			redirect_to root_url
		end
	end

	protected

	def invite_params
	   params.require(resource_name).permit(
	      :email,
	      :role,
	      :company_id
	    )
	end

	#check if the company has subscription plans
	def has_subscription
		if current_agent.company.subscription.nil?
			flash[:error] = "You need to choose a plan before you start inviting agents."
			redirect_to new_subscription_path
		else
			true
		end
	end

end