class CompaniesController < ApplicationController

  before_filter :authenticate_agent!
  before_filter :authorize #check if user is admin

  def new
    @company = Company.new
  end

  def create
    @company = Company.create(params[:company])
    if @company.save
      current_agent.company = @company
      current_agent.save
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
    if @company.update_attributes(params[:company]) && @company.agents.inlcude?(current_agent)
      flash[:success] = "Company details were updated successfully!"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong. Please review the problems below."
      render :action => "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.delete
      flash[:success] = "Sad to see you go! Company details were successfully deleted!"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong. Please review the problems"
      redirect_to :back
    end
  end

end
