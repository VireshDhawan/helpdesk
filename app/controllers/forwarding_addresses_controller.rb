class ForwardingAddressesController < ApplicationController

	before_filter :authenticate_agent!
	before_filter :authorize_admin
	layout "admin_panel"

	def index
		@forwarding_addresses = current_agent.company.forwarding_addresses
	end

	def new
		@forwarding_address = current_agent.company.forwarding_addresses.new
	end

	def create
		@forwarding_address = current_agent.company.forwarding_addresses.create(params[:forwarding_address])
		if @forwarding_address.save
			flash[:success] = "Forwarding address was successfully created!"
			redirect_to forwarding_addresses_path
		else
			flash[:error] = "Something went wrong. Please try again!"
			render :action => "new"
		end
	end

	def edit
		@forwarding_address = current_agent.company.forwarding_addresses.find(params[:id])
	end

	def update
		@forwarding_address = current_agent.company.forwarding_addresses.find(params[:id])
		if @forwarding_address.update_attributes(params[:forwarding_address])
			flash[:success] = "Forwarding address was successfully updated!"
			redirect_to forwarding_addresses_path
		else
			flash[:error] = "Something went wrong. Please try again!"
			render :action => "edit"
		end
	end

	def destroy
		@forwarding_address = current_agent.company.forwarding_addresses.find(params[:id])
		if @forwarding_address.delete
	      flash[:success] = "Forwarding Address was successfully deleted!"
	      redirect_to forwarding_addresses_path
	    else
	      flash[:error] = "Something went wrong. Please try again!"
	      redirect_to :back
	    end
	end

end
