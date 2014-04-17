class AgentInvitationsController < Devise::InvitationsController

	prepend_before_filter :has_subscription, only: [:new,:create,:destroy]
	prepend_before_filter :require_company
	prepend_before_filter :can_invite, only: [:new,:create,:destroy]

	layout "admin_panel"

	def index
		@admins = current_agent.company.agents.where(role: true)
		@agents = current_agent.company.agents.where(role: false)
	end
	# GET /resource/invitation/new
	def new
		self.resource = resource_class.new
		render :new
	end

	# POST /resource/invitation
	def create
		self.resource = invite_resource

		if resource.errors.empty?
		  yield resource if block_given?
		  set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
		  respond_with resource, :location => after_invite_path_for(resource)
		else
		  respond_with_navigational(resource) { render :new }
		end
	end

	# GET /resource/invitation/accept?invitation_token=abcdef
	def edit
		resource.invitation_token = params[:invitation_token]
		render :edit
	end

	# PUT /resource/invitation
	def update
		self.resource = accept_resource

		if resource.errors.empty?
		  yield resource if block_given?
		  flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
		  set_flash_message :notice, flash_message
		  sign_in(resource_name, resource)
		  respond_with resource, :location => after_accept_path_for(resource)
		else
		  respond_with_navigational(resource){ render :edit }
		end
	end

	# GET /resource/invitation/remove?invitation_token=abcdef
	def destroy
		resource.destroy
		set_flash_message :notice, :invitation_removed
		redirect_to after_sign_out_path_for(resource_name)
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
			redirect_to root_url
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
			:allow_subscription_management,
			:first_name,
			:last_name,
			:signature,
			:api_token
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