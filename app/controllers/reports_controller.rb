class ReportsController < ApplicationController

	before_filter :authenticate_agent!, :authorize_reporting
	layout "reports_panel"

	def index
		# tickets graph
		gon.date_range = last_7_days
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
