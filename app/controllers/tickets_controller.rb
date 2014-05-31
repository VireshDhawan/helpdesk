class TicketsController < ApplicationController

  before_filter :authenticate_agent!, except: [:messages]
  skip_before_filter :verify_authenticity_token, only: [:messages]
  
  layout "control_panel"

  def index
    if params[:type] == "unassigned"
      # Unassigned
      tickets = current_agent.company.tickets.in_category("Unassigned")
      @answered_tickets = tickets.select {|t| t.answered?}
      @unanswered_tickets = tickets.select {|t| !t.answered?}
      @type = params[:type]
    elsif params[:type] == "my"
      # Agent
      tickets = current_agent.tickets
      @answered_tickets = tickets.select {|t| t.answered?}
      @unanswered_tickets = tickets.select {|t| !t.answered?}
      @type = params[:type]
    elsif params[:type] == "groups"
      # Groups
      tickets = current_agent.all_group_tickets
      @answered_tickets = tickets.select {|t| t.answered?}
      @unanswered_tickets = tickets.select {|t| !t.answered?}
      @type = params[:type]
    elsif params[:type] == "trash"
      # Trash
      @tickets = current_agent.company.tickets.in_category("Trash")
      @type = params[:type]
    elsif params[:type] == "archived"
      # Archived
      @tickets = current_agent.company.tickets.in_category("Archived")
      @type = params[:type]
    elsif params[:type] == "spam"
      # Spam
      @tickets = current_agent.company.tickets.in_category("Spam")
      @type = params[:type]
    else
      # All
      @tickets = current_agent.company.tickets
      @type = "all"
    end
  end

  def new
    ## check for the company to which the ticket is being created
    @ticket = current_agent.company.tickets.new
    @reply_emails = current_agent.company.forwarding_addresses.pluck(:from)
  end

  def create
    @ticket = current_agent.company.tickets.create(params[:ticket])
    if @ticket.save
      filter = Filter.get_matching_filter(@ticket.company,@ticket)
      @ticket.add_filter(filter.first) unless filter.blank?
      Mailer.delay(queue: "helpdesk_ticket_queue").new_ticket_by_agent_mail(@ticket) if @ticket.notify_customer?
      flash[:success] = "Ticket was successfully created!"
      redirect_to @ticket
    else
      flash[:error] = "There was some error. Please check again!"
      render :action => "new"
    end
  end

  def show
    @ticket = current_agent.company.tickets.find(params[:id])
    @activities = (@ticket.replies + @ticket.comments).sort{|a,b| a.created_at <=> b.created_at }
    @reply = @ticket.replies.new
    @comment = @ticket.comments.new
  end

  def edit
    @ticket = current_agent.company.tickets.find(params[:id])
  end

  def update
    @ticket = current_agent.company.tickets.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      filter = Filter.get_matching_filter(@ticket.company,@ticket)
      @ticket.add_filter(filter.first) unless filter.blank?
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

  def messages
    recipient, from, subject = params[:recipient], params[:from].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).first, params[:subject]
    customer_name = params[:from].split("<").map(&:strip)[0]
    reply_email = ForwardingAddress.get_reply_email(recipient)
    company = ForwardingAddress.get_company_of_address(recipient)
    tickets = company.tickets
    # find ticket
    ticket = tickets.where(customer_email: from,reply_email: reply_email).where(
      'subject ~ :pat', :pat => '(Re: |)^'+subject+'$').order("created_at DESC").first
    # if found add reply
    if ticket
      reply = ticket.replies.create(params[:"stripped-html"])
      if reply.save
        respond_to do |format|
          format.json {render json: "Reply was created successfully!"}
          format.html {flash[:success] = "Reply was created successfully!"}
        end
      else
        respond_to do |format|
          format.json {render json: "There was some errro. Please try again!"}
          format.html {flash[:success] = "There was some errro. Please try again!"}
        end
      end
    else
      # if not found create ticket
      ticket_params = {
        customer_email: from,reply_email: reply_email, customer_name: customer_name,
        subject: params[:subject], message: params[:"stripped-html"],
        ticket_category_id: 1
      }
      ticket = company.tickets.create(ticket_params)
      if ticket.save
        filter = Filter.get_matching_filter(ticket.company,ticket)
        ticket.add_filter(filter.first) unless filter.blank?
        respond_to do |format|
          format.json {render json: "Ticket was created successfully!"}
          format.html {flash[:success] = "Ticket was created successfully!"}
        end
      else
        respond_to do |format|
          format.json {render json: "There was some errro. Please try again!"}
          format.html {flash[:success] = "There was some errro. Please try again!"}
        end
      end
    end

    #avoid rendering template for post  
    render :nothing => true
  end

  # Misc methods to assing, spam, trash tickets
  def assign
    
  end

end

