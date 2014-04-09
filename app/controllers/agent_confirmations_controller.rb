class AgentConfirmationsController < Devise::ConfirmationsController

  def show
    @original_token = params[:confirmation_token]
    digested_token = Devise.token_generator.digest(self, :confirmation_token,params[:confirmation_token])
    self.resource = resource_class.find_by_confirmation_token(digested_token) if params[:confirmation_token].present?
    super if resource.nil? or resource.confirmed?
  end

  def confirm
    # digested_token = Devise.token_generator.digest(self, :confirmation_token, params[resource_name][:confirmation_token]) # Digested token only needed in the first instance unless show.html.haml is altered
    digested_token = params[resource_name][:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token(digested_token) if params[resource_name][:confirmation_token].present?
    if resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.password_match?
      #self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      resource.update_attributes(
        confirmed_at: Time.now,
        :allow_reporting => true,
        :allow_agent_management => true,
        :allow_to_invite => true,
        :allow_billing_management => true,
        :allow_company_management => true,
        :allow_subscription_management => true
      )
      set_flash_message :notice, :confirmed
      if resource.company.nil?
        flash[:notice] = "Upate your Company info"
        redirect_to new_company_path
      else
        flash[:notice] = "Upate your info"
        redirect_to edit_agent_registration_path
      end
    else
      render :action => "show"
    end    
  end

end