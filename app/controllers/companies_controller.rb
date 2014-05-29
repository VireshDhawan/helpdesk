class CompaniesController < ApplicationController

  before_filter :authenticate_agent!
  before_filter :authorize_admin #check if user is admin
  before_filter :authorize_company_privilages
  
  helper_method :authorize_company_privilages

  layout "admin_panel",except: [:new,:create]

  @@domain = "sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org"
  
  def new
    @company = Company.new
    render :layout => "accounts"
  end

  def create
    @company = Company.create(params[:company])
    if @company.save
      current_agent.company = @company
      current_agent.save
      MailgunTasks.create_first_credentials(@company)
      @company.update_attributes(email: "#{@company.name.downcase}-support@#{@@domain}")
      flash[:success] = "Company details were updated successfully!"
      redirect_to new_subscription_path
    else
      flash[:error] = "Something went wrong. Please review the problems below."
      render :action => "new"
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if current_agent.company == @company
      if @company.update_attributes(params[:company])
        flash[:success] = "Company details were updated successfully!"
        redirect_to admin_path
      else
        flash[:error] = "Something went wrong. Please review the problems below."
        render :action => "edit"
      end
    else
      flash[:error] = "Something went wrong. Please review the problems below."
      render :action => "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      flash[:success] = "Sad to see you go! Company details were successfully deleted!"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong. Please review the problems"
      redirect_to :back
    end
  end

  def authorize_company_privilages
    unless current_agent.allow_company_management
      flash[:error] = "You are not authorized to perform the action"
      #redirect to default page
      redirect_to(:back) rescue redirect_to root_url
    else
      true
    end   
  end

end
