class AgentsController < ApplicationController

	before_filter :authenticate_agent!
	before_filter :check_if_allowed_to_manage_agents
	layout "admin_panel"

	def edit
		@agent = current_agent.company.agents.find(params[:id])
	end

	def update
		@agent = current_agent.company.agents.find(params[:id])
		if params[:agent][:password].blank?
		  params[:agent].delete(:password)
		  params[:agent].delete(:password_confirmation)
		end
		if @agent.update_attributes(params[:agent])
			redirect_to(admin_path)
			flash[:success] = "Agent permissions were successfully updated!"
		else
			flash[:error] = "Something went wrong. Please review the errors below."
			render :action => "edit"
		end
	end

	#before delete take care of dependencies
	def destroy
		@agent = current_agent.company.agents.find(params[:id])
	    if @agent.destroy
	      flash[:success] = "Agent was successfully deleted!"
	      redirect_to :back
	    else
	      flash[:error] = "Something went wrong. Please review the problems"
	      redirect_to :back
	    end
	end

	protected

	def check_if_allowed_to_manage_agents
		unless current_agent.allow_agent_management
			flash[:error] = "You are not authorized to manage agent permissions."
      		redirect_to admin_path
		else
			true
		end
	end

end
