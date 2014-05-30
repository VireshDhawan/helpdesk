class CommentsController < ApplicationController

	before_filter :authenticate_agent!

	def create
		@comment = current_agent.comments.create(params[:comment])
		if @comment.save
			flash[:success] = "Comment was created successfully!"
			redirect_to :back
		else
			flash[:error] = "Comment " + @comment.errors.full_messages.join(", ")
			redirect_to :back
		end
	end

	def update
		@comment = current_agent.comments.find(params[:id])
		if @comment.save
			flash[:success] = "Comment was updated successfully!"
			redirect_to :back
		else
			flash[:error] = "Comment " + @comment.errors.full_messages.join(", ")
			redirect_to :back
		end
	end

	def delete
		@comment = current_agent.comments.find(params[:id])
		if @comment.delete
			flash[:success] = "Comment was deleted successfully!"
			redirect_to :back
		end
	end

end
