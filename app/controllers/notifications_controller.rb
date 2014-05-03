class NotificationsController < ApplicationController

	before_filter :authenticate_agent!
	layout "admin_panel"

	def edit
		@notification = current_agent.notification
	end

	def update
		@notification = current_agent.notification
		if @notification.update_attributes(params[:notification])
			flash[:success] = "Your notification preferences were updated successfully!"
			redirect_to(:back) rescue redirect_to root_url
		else
			flash[:error] = "Something went wrong. Please try again!"
			render :action => "new"
		end
	end

end
