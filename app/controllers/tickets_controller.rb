class TicketsController < ApplicationController

  before_filter :authenticate_agent!
  
  layout "control_panel"

  def index
    if params[:type] == "unassigned"
      category = TicketCategory.find_by(name: "Unassigned")
      @tickets = current_agent.company.tickets.select{|t| t.ticket_category == category}
    elsif
      @tickets = current_agent.company.tickets
    end
  end

  def new
    ## check for the company to which the ticket is being created
    @ticket = current_agent.company.tickets.new
  end

  def create
    @ticket = current_agent.company.tickets.create(params[:ticket])
    if @ticket.save
      filter = Filter.get_matching_filter(@ticket.company,@ticket)
      unless filter.blank?
        @ticket.add_filter(filter)          
      end
      flash[:success] = "Ticket was successfully created!"
      redirect_to @ticket
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "new"
    end
  end

  def show
    @ticket = current_agent.company.tickets.find(params[:id])
  end

  def edit
    @ticket = current_agent.company.tickets.find(params[:id])
  end

  def update
    @ticket = current_agent.company.tickets.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:success] = "Ticket was successfully updated!"
      redirect_to @ticket
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "edit"
    end
  end

  def destroy
    @ticket = current_agent.company.tickets.find(params[:id])
    if @ticket.delete
      flash[:success] = "Ticket was successfully deleted!"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong. Please review the problems"
      redirect_to :back
    end
  end

end
