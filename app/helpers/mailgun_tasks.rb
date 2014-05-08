# We define all mailgun related tasks methods here
# For ex. send messages, create senders, manage domains, routing
# all

class MailgunTasks

	@@private_key = "key-3uwe3fmmable7pzexhhp8fhnt1pkr6d4"
	@@public_key = "pubkey-2065eu46y1g3uvvvu32jbq88iq4ppwm1"
	@@domain = "sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org"

	class  << self

		def send_simple_message
		  RestClient.post "https://api:#{@@private_key}"\
		  "@api.mailgun.net/v2/#{@@domain}/messages",
		  :from => "Helpdesk <postmasters@#{@@domain}>",
		  :to => "xmpirate.m@gmail.com",
		  :subject => "Hello",
		  :text => "Testing some Mailgun awesomness!"
		end

		def send_complex_message
		  data = Multimap.new
		  data[:from] = "Excited User <postmasters@#{@@domain}>"
		  data[:to] = "xmpirate.m@gmail.com"
		  #data[:cc] = "baz@example.com"
		  #data[:bcc] = "bar@example.com"
		  data[:subject] = "Hello"
		  #data[:text] = "Testing some Mailgun awesomness!"
		  data[:html] = render_to_string(:template =>"mailgun_mails/send_complex_message.html.erb")
		  #data[:attachment] = File.new(File.join("files", "test.jpg"))
		  #data[:attachment] = File.new(File.join("files", "test.txt"))
		  response = RestClient.post "https://api:#{@@private_kay}"\
		  "@api.mailgun.net/v2/#{@@domain}/messages", data

		  response = JSON.parse(response)

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

		##create email senders for each tenant
		def create_credentials(username,password)
		  response = RestClient.post("https://api:#{@@private_key}"\
		  		  "@api.mailgun.net/v2/domains/#{@@domain}/credentials",
		  		  :login => "#{username}@#{@@domain}",
		  		  :password => password
		  		  )

		  response = JSON.parse(response)
		  return response["message"]
		end

		def delete_credentials(username)
		  response = RestClient.delete "https://api:#{@@private_key}"\
		  "@api.mailgun.net/v2/domains/#{@@domain}/credentials/#{username}"

		  response = JSON.parse(response)
		end

		def change_credential_password(username,new_password)
		  response = RestClient.put "https://api:#{@@private_key}"\
		  "@api.mailgun.net/v2/#{@@domain}/credentials/#{username}",
		  :password => new_password

		  response = JSON.parse(response)
		end

		def get_credentials
		  response = RestClient.get "https://api:#{@@private_key}"\
		  "@api.mailgun.net/v2/domains/#{@@domain}/credentials"

		  response = JSON.parse(response)
		end

		## Routes
		def create_route
		  data = Multimap.new
		  data[:priority] = 1
		  data[:description] = "Sample route"
		  data[:expression] = "match_recipient('.*@#{@@domail}')"
		  data[:action] = "forward('http://myhost.com/messages/')"
		  data[:action] = "stop()"
		  response = RestClient.post "https://api:#{@@private_key}"\
		  "@api.mailgun.net/v2/routes", data

		  response = JSON.parse(response)
		end

		def get_routes
		  response = RestClient.get "https://api:#{@@private_key}"\
		  "@api.mailgun.net/v2/routes", :params => {
		    :skip => 1,
		    :limit => 1
		  }

		  response = JSON.parse(response)
		end

		def get_route(route_id)
		  response = RestClient.get("https://api:#{@@private_key}"\
		        "@api.mailgun.net/v2/routes/"\
		        "#{route_id}"){|response, request, result| response }

		  response = JSON.parse(response)
		end


	end
end