class ReportsController < ApplicationController

	before_filter :authenticate_agent!, :authorize_reporting
	layout "reports_panel"

	def index
		@your_int = 123
		gon.your_int = @your_int
	end

	def agents
		
	end

	def groups
		
	end

	def labels
		
	end

end
