class AdminController < ApplicationController

	before_filter :authenticate_agent!
	layout "admin_panel"

	def index
	end

end
