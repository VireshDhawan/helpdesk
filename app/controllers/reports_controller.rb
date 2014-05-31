class ReportsController < ApplicationController

	before_filter :authenticate_agent!, :authorize_reporting
	layout "reports_panel"

	protect_from_forgery with: :exception

	def index
		date1 = Date.today - 30.days
		date2 = Date.today
		company = current_agent.company

		#tickets count grouped by date and count
		gon.tickets_count = Ticket.in_date_range_with_count(date1,date2,nil,company)

		# archived tickets grouped by date and count
		gon.archived_tickets = Ticket.in_date_range_with_count(date1,date2,"Archived",company)

		# replies grouped by date and count
		gon.replies_count = Reply.in_date_range_for_replies(date1,date2,company)
	end

	def agents
		
	end

	def groups
		
	end

	def labels
		
	end

	def charts
		dates = params[:daterange].split(" - ")
		date1 = Date.parse dates[0]
		date2 = Date.parse dates[1]
		company = current_agent.company
		@tickets_count = Ticket.in_date_range_with_count(date1,date2,nil,company)
		gon.tickets_count = Ticket.in_date_range_with_count(date1,date2,nil,company)

		# archived tickets grouped by date and count
		@archived_tickets = Ticket.in_date_range_with_count(date1,date2,"Archived",company)
		gon.archived_tickets = Ticket.in_date_range_with_count(date1,date2,"Archived",company)

		# replies grouped by date and count
		@replies_count = Reply.in_date_range_for_replies(date1,date2,company)
		gon.replies_count = Reply.in_date_range_for_replies(date1,date2,company)

		respond_to do |format|
	      format.js
	    end	
	end

end
