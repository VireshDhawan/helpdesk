class SubscriptionsController < ApplicationController

	before_filter :authenticate_agent!
	before_filter :authorize_admin #check if user is admin
	before_filter :authorize_subscription_privilages

	layout "admin_panel",except: [:new,:create]

	def index
		@subscription = current_agent.company.subscription
	end

	def new
		@subscription = Subscription.new
		render :layout => "accounts"
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
			unless params[:billing][:billing_period].blank?
				if @subscription.update_attributes(params[:billing])
					flash[:success] = "Billing Period was updated successfully!"
					redirect_to :back
				end
			end
		end
	end

=begin
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
=end	

	protected

	def authorize_subscription_privilages
		unless current_agent.allow_subscription_management || current_agent.allow_billing_management
			flash[:error] = "You are not authorized to perform the action"
			#redirect to default page
			redirect_to(:back) rescue redirect_to root_url
		else
			true
		end		
	end

end
