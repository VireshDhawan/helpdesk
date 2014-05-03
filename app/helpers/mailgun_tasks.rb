# We define all mailgun related tasks methods here
# For ex. send messages, create senders, manage domains, routing
# all

class MailgunTasks

	@@private_key = "key-3uwe3fmmable7pzexhhp8fhnt1pkr6d4"
	@@public_key = "pubkey-2065eu46y1g3uvvvu32jbq88iq4ppwm1"

	class  << self

		def send_simple_message
		  RestClient.post "https://api:#{@@private_key}"\
		  "@api.mailgun.net/v2/sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org/messages",
		  :from => "Helpdesk <postmasters@sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org>",
		  :to => "xmpirate.m@gmail.com",
		  :subject => "Hello",
		  :text => "Testing some Mailgun awesomness!"
		end

		def validate_email(email)
		  url_params = Multimap.new
		  url_params[:address] = email
		  query_string = url_params.collect {|k, v| "#{k.to_s}=#{CGI::escape(v.to_s)}"}.
		    join("&")
		  response = RestClient.get "https://api:#{@@public_key}"\
		  "@api.mailgun.net/v2/address/validate?#{query_string}", {:accept => :json}

		  response = JSON.parse(response)
		end

	end
end