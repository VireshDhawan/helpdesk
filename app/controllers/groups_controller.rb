class GroupsController < ApplicationController

  before_filter :authenticate_agent!
  before_filter :authorize_admin
  before_filter :check_group_management

  layout "admin_panel"

  def index
    @groups = current_agent.company.groups
  end

  def new
    ## check for the company to which the group is being created
    @group = current_agent.company.groups.new
  end

  def create
    if current_agent.company == Company.find(params[:group][:company_id]) 
      @group = Group.create(params[:group])
      if @group.save
        flash[:success] = "Group was successfully created!"
        redirect_to groups_path
      else
        flash[:error] = "There was some error. Please check again!"
        render :action => "new"
      end
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "new"
    end
  end

  def edit
    @group = current_agent.company.groups.find(params[:id])
  end

  def update
    @group = current_agent.company.groups.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = "Group was successfully updated!"
      redirect_to groups_path
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "edit"
    end
  end

  def destroy
    @group = current_agent.company.groups.find(params[:id])
    if @group.destroy
      flash[:success] = "Group was successfully deleted!"
      redirect_to :back
    else
      flash[:error] = "Something went wrong. Please review the problems"
      redirect_to :back
    end
  end

  protected

  def check_group_management
    unless current_agent.allow_groups_management
      flash[:error] = "You are not authorized to manage groups. Contact your account administrator."
      redirect_to admin_path
    else
      true
    end
  end

end
