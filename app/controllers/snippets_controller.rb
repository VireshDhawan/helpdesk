class SnippetsController < ApplicationController

	before_filter :authenticate_agent!
	layout "admin_panel"

	def index
		@company_snippets = current_agent.company.snippets
		@snippets = current_agent.snippets
	end

	def new
		@snippet = Snippet.new
	end

	def create
		if params[:snippet][:scope]=="true" && current_agent.is_admin?
			@snippet = current_agent.company.snippets.create(params[:snippet])
			if @snippet.save
				flash[:success] = "Snippet was successfully created!"
				redirect_to snippets_path
			else
				flash[:error] = "Something went wrong. Please review the problems below."
				render :action => "new"
			end
		else
			@snippet = current_agent.snippets.create(params[:snippet])
			if @snippet.save
				flash[:success] = "Snippet was successfully created!"
				redirect_to snippets_path
			else
				flash[:error] = "Something went wrong. Please review the problems below."
				render :action => "new"
			end
		end
	end

	def edit
		snippet = Snippet.find(params[:id])
		# if company wide snippet only admin can edit
		if snippet.scope && current_agent.is_admin?
			@snippet = current_agent.company.snippets.find(params[:id])
		#if agent's snippet only agent can edit			
		elsif !snippet.scope && current_agent == snippet.snippetable
			@snippet = current_agent.snippets.find(params[:id])
		else
			flash[:error] = "Snippet not found."
			redirect_to snippets_path
		end
	end

	def update
		snippet = Snippet.find(params[:id])
		if snippet.scope && current_agent.is_admin?
			snippet.update_attributes(params[:snippet])
			snippet.snippetable = current_agent if snippet.scope == false
			snippet.save
			redirect_to snippets_path
		elsif !snippet.scope && current_agent.is_admin?
			snippet.update_attributes(params[:snippet])
			snippet.snippetable = current_agent.company if snippet.scope == true
			snippet.save
			redirect_to snippets_path
		elsif !snippet.scope && current_agent == snippet.snippetable
			snippet.update_attributes(params[:snippet])
			snippet.save
			redirect_to snippets_path
		else
			flash[:error] = "Snippet not found."
			render :action => "edit"
		end
	end

	def destroy
		snippet = Snippet.find(params[:id])
		# if company wide snippet only admin can delete
		if snippet.scope && current_agent.is_admin?
			@snippet = current_agent.company.snippets.find(params[:id])
			@snippet.destroy
			redirect_to snippets_path
		# if agent's snippet only agent can delete
		elsif !snippet.scope && current_agent == snippet.snippetable
			@snippet = current_agent.snippets.find(params[:id])
			@snippet.destroy
			redirect_to snippets_path
		else
			flash[:error] = "Snippet not found."
			redirect_to snippets_path
		end
	end

end
