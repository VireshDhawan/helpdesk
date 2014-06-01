class Agents::RegistrationsController < Devise::RegistrationsController

	before_filter :configure_permitted_parameters
 
	protected

	def after_update_path_for(resource)
      admin_path
    end
	 
	# my custom fields are :name, :heard_how
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:account_update) do |u|
			u.permit(:email, :password, :password_confirmation,
			 :current_password,:first_name,:last_name,:role,
			 :signature,:api_token,:company_id,:allow_reporting,
			 :allow_agent_management,:allow_to_invite,:allow_billing_management,
			 :allow_company_management,:allow_subscription_management,
			 :allow_groups_management)
		end
	end

end