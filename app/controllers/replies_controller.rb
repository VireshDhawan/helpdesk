class RepliesController < ApplicationController

	before_filter :authenticate_agent!

	def create
		@reply = current_agent.replies.create(params[:reply])
		if @reply.save
			flash[:success] = "Your reply was posted successfully!"
			redirect_to :back
		else
			flash[:error] = "Reply " + @reply.errors.full_messages.join(", ")
			redirect_to :back
		end
	end

end
