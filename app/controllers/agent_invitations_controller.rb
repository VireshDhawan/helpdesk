class AgentInvitationsController < Devise::InvitationsController

	prepend_before_filter :has_subscription, only: [:new,:create,:destroy]
	prepend_before_filter :require_company
	prepend_before_filter :can_invite, only: [:new,:create,:destroy]

	layout "admin_panel", :except => [:edit,:update]

	def index
		@admins = current_agent.company.agents.where(role: true)
		@agents = current_agent.company.agents.where(role: false)
	end

	def update
		self.resource = accept_resource

		if resource.errors.empty?
			if resource.role
				resource.update_attributes(allow_reporting: true,
					allow_agent_management: true,
					allow_to_invite: true
				)
			end
		  yield resource if block_given?
		  flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
		  set_flash_message :notice, flash_message
		  sign_in(resource_name, resource)
		  respond_with resource, :location => after_accept_path_for(resource)
		else
		  respond_with_navigational(resource){ render :edit }
		end
	end
	
	private

	def invite_resource
	## skip sending emails on invite
		resource_class.invite!(invite_params, current_inviter)
	end

	def after_accept_path_for(resource)
		edit_agent_registration_path
	end

	def can_invite
		#check if allowed to invite admin
		unless current_agent && current_agent.allow_to_invite?
			flash[:error] = "You are not allowed to perform the action"
			redirect_to(:back) rescue redirect_to(root_url)
		end
	end

	protected

	def invite_params
	   params.require(resource_name).permit(
			:email,
			:role,
			:company_id,
			:allow_reporting,
			:allow_agent_management,
			:allow_to_invite,
			:allow_billing_management,
			:allow_company_management,
			:allow_subscription_management
	    )
	end

	#check if the company has subscription plans!
	def has_subscription
		if current_agent.company.subscription.nil?
			flash[:error] = "You need to choose a plan before you start inviting agents."
			redirect_to new_subscription_path
		else
			true
		end
	end

end