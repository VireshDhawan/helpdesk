class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
# prepend_before_filter :require_company
# prepend_before_filter :subscription_expired
#  around_filter :catch_not_found

  def after_update_path_for(resource)
    admin_path
  end

  protected

  def authorize_admin
    unless current_agent.role
      flash[:error] = "You are not authorized to perform the action"
      #redirect to default page
      redirect_to(:back) rescue redirect_to(root_url)
    else
      true
    end
  end

  def authorize_reporting
    unless current_agent.allow_reporting?
      flash[:error] = "You are not authorized to perform the action"
      #redirect to default page
      redirect_to(:back) rescue redirect_to(root_url)
    else
      true
    end
  end

  def require_company
    if current_agent && current_agent.role && current_agent.company.nil?
      flash[:error] = "You need to provide company details before you invite agents."
      redirect_to new_company_path
    elsif current_agent && current_agent.company.nil?
      flash[:error] = "Your account is not yet activated. Contact your account administrator."
      redirect_to :back
    end
  end

  def subscription_expired
    # something which restricts agents (all agents) access to dashboard
    # if the company's subscription failed/expired 
    # if current_agent is logged in and is 'Admin'
    # redirect_to edit_subscription_path
    # else only display notification to normal agent to contact Administrator!
  end

  def authorize_superadmin
    unless current_superadmin
      flash[:warning] = "You are not authorized to perform the action."
      redirect_to root_url
    end
  end

  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to :back, :flash => { :error => "Record not found."}
  end

end
