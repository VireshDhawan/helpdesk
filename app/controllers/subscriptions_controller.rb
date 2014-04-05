class SubscriptionsController < ApplicationController

	before_filter :authenticate_agent!
	before_filter :authorize #check if user is admin

	def new
		@subscription = Subscription.new
	end

	def create
		if current_agent.company == Company.find(params[:subscription][:company_id])
			@subscription = Subscription.create(params[:subscription])
			if @subscription.save
				flash[:success] = "Subscription details were updated successfully!"
				#redirect_to dashboard
	      		redirect_to edit_agent_registration_path
			else
				flash[:error] = "Something went wrong! Please review the problems below."
				@error_messages = @subscription.errors.full_messages
	      		render :action => "new"
			end
		else
			flash[:error] = "Please update your own company subscription."
      		render :action => "new"
		end
	end

	def edit
		@subscription = Subscription.find(params[:id])
	end

	def update
		@subscription = Subscription.find(params[:id])
		if @subscription.company == current_agent.company
			if @subscription.update_attributes(params[:subscription])
				flash[:success] = "Subscription details were updated successfully!"
				#redirect_to dashboard/current_page
	      		redirect_to :back
			else
				@error_messages = @subscription.errors.full_messages
				flash[:error] = "Something went wrong! Please review the problems below."
				render :action => "edit"
			end
		else
			flash[:error] = "Please update your own company subscription."
      		render :action => "edit"
		end
	end

end
