class LabelsController < ApplicationController

  before_filter :authenticate_agent!
  layout "admin_panel"

  def index
    @labels = current_agent.company.labels
  end

  def new
    ## check for the company to which the label is being created
    @label = current_agent.company.labels.new
  end

  def create
    @label = current_agent.company.labels.create(params[:label])
    if @label.save 
      flash[:success] = "Label was successfully created!"
      redirect_to labels_path
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "new"
    end
  end

  def edit
    @label = current_agent.company.labels.find(params[:id])
  end

  def update
    @label = current_agent.company.labels.find(params[:id])
    if @label.update_attributes(params[:label])
      flash[:success] = "label was successfully updated!"
      redirect_to labels_path
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "edit"
    end
  end

  def destroy
    @label = current_agent.company.labels.find(params[:id])
    if @label.delete
      flash[:success] = "The Label was successfully deleted!"
      redirect_to labels_path
    else
      flash[:error] = "Something went wrong. Please review the problems"
      redirect_to :back
    end
  end
  
end
