class SuperadminInvitationsController < Devise::InvitationsController

	prepend_before_filter :authorize_superadmin, only: [:new,:create,:destroy]
	before_filter :authenticate_superadmin!
	layout "super_admin"
		
	private

	def invite_resource
	## skip sending emails on invite
		resource_class.invite!(invite_params, current_inviter)
	end

	def after_accept_path_for(resource)
		edit_superadmin_registration_path
	end

	protected

	def invite_params
	   params.require(resource_name).permit(
	      :email
#	      :role,
#	      :company_id
	    )
	end
	
end