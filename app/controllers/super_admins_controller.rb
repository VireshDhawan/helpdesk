class SuperAdminsController < ApplicationController

	before_filter :authenticate_superadmin!
	layout "super_admin"
	
	def index
	end

end
