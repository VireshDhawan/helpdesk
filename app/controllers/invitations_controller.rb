class InvitationsController < Devise::InvitationsController

	prepend_before_filter :if_admin, only: [:new,:create,:destroy]

	private
	# this is called when creating invitation
	# should return an instance of resource class
#	def invite_resource(&block)
#		agent = resource_class.invite!(invite_params, current_inviter, &block)
#		agent.company = current_inviter.company
#		agent.save
#		return agent
#	end

	def invite_resource
	## skip sending emails on invite
		resource_class.invite!(invite_params, current_inviter)
	end

	def after_accept_path_for(resource)
		edit_agent_registration_path
	end

	def if_admin
		unless current_agent.role
			flash[:error] = "You are not authorized to invite other Agents."
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

end