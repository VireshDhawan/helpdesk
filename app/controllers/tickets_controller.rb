class TicketsController < ApplicationController

  before_filter :authenticate_agent!, except: [:new,:create]
  
  layout "control_panel"

  def index
    @tickets = current_agent.company.tickets
  end

  def new
    ## check for the company to which the ticket is being created
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.create(params[:ticket])
    if @ticket.save
      flash[:success] = "Ticket was successfully created!"
      redirect_to @ticket
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "new"
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:success] = "Ticket was successfully updated!"
      redirect_to @ticket
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "edit"
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    if @ticket.delete
      flash[:success] = "Ticket was successfully deleted!"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong. Please review the problems"
      redirect_to :back
    end
  end

end
