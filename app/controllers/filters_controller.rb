class FiltersController < ApplicationController
	
	before_filter :authenticate_agent!
	layout "admin_panel"

	def index
		@filters = current_agent.company.filters
	end

	def new
		@filter = current_agent.company.filters.new
	end

	def create
		@filter = current_agent.company.filters.create(params[:filter])
		if @filter.save
			flash[:success] = "Filter was successfully created!"
			redirect_to filters_path
		else
			flash[:error] = "There was some error. Please review the problems below."
			render :action => "new"
		end
	end

	def edit
		@filter = current_agent.company.filters.find(params[:id])
	end

	def update
		@filter = current_agent.company.filters.find(params[:id])
		if @filter.update_attributes(params[:filter])
			flash[:success] = "Filter was successfully updated!"
			redirect_to filters_path
		else
			flash[:error] = "There was some error. Please review the problems below."
			render :action => "edit"
		end
	end

	def destroy
		@filter = current_agent.company.filters.find(params[:id])
		if @filter.destroy
			flash[:success] = "Filter was successfully deleted!"
			redirect_to filters_path
		else
			flash[:error] = "There was some error. Please review the problems below."
			redirect_to(:back)
		end
	end

end
