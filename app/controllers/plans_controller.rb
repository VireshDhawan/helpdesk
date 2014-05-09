class PlansController < ApplicationController

  before_filter :authorize_superadmin
  before_filter :authenticate_superadmin!

  def index
    #list all the plans
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.create(params[:plan])
    if @plan.save
      flash[:success] = "New plan was created successfully!"
      #redirect_to @plan
    else
      flash[:error] = "Something went wrong. Please review the problems below."
      render :action => "new"
    end
  end

  def show
    #show a particular plan
    @plan = Plan.find(params[:id])
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(params[:plan])
      flash[:success] = "Plan details were successfully updated!"
      #redirect_to @plan
    else
      flash[:error] = "Something went wrong. Please review the problems below."
      render :action => "edit"      
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    if @plan.destroy
      flash[:success] = "Plan was successfully deleted!"
      redirect_to plans_path
    else
      flash[:error] = "There was some error deleting the plan"
      redirect_to :back
    end
  end

end
