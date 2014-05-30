class ReportsController < ApplicationController

	before_filter :authenticate_agent!, :authorize_reporting
	layout "reports_panel"

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

	private

	def last_7_days
		date1 = Date.today
		date2 = date1 - 1.week
		date_range = (date2..date1).to_a.map {|d| d.strftime "%d %b" }
	end

	def last_7_days_data
		date = Date.today - 1.week
		tickets = current_agent.company.tickets.where("date(created_at) > ?", 7.days.ago)
	end

	def yesterday
		day = Date.today - 1
	end

end
