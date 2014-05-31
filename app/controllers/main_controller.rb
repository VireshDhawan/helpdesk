class MainController < ApplicationController

	skip_before_action :verify_authenticity_token, only: [:contact]

	def index
	end

	def features
	end

	def faq
	end

	def pricing
		@plans = Plan.all
	end

	def contact
		unless params[:email].blank?
			details = OpenStruct.new(Hash[
					"name" => params[:name],"email" => params[:email],
					"subject" => params[:subject],"text" => params[:text]
				])
			if Mailer.send_contact_mail(details)
				flash[:success] = "Your response was recorded. We'll get back to you soon!"
			else
				flash[:error] = "Something went wrong. Please try again!"
			end
		end
	end
	
end
