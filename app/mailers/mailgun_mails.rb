class MailgunMails < ActionMailer::Base
  
  	@@private_key = "key-3uwe3fmmable7pzexhhp8fhnt1pkr6d4"
	@@public_key = "pubkey-2065eu46y1g3uvvvu32jbq88iq4ppwm1"
	@@domain = "sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org"

  	def send_complex_message
	  data = Multimap.new
	  data[:from] = "Hello User <postmasters@#{@@domain}>"
	  data[:to] = "xmpirate.m@gmail.com"
	  #data[:cc] = "baz@example.com"
	  #data[:bcc] = "bar@example.com"
	  data[:subject] = "Brody Buddy"
	  #data[:text] = "Testing some Mailgun awesomness!"
	  #html = File.open("#{Rails.root}/app/views/mailgun_mails/send_complex_message.html.erb").read
	  html_output = render_to_string(template: "mailgun_mails/send_complex_message", :locals => {:data => "Mrduul"})
	  data[:html] = html_output.to_str
	  #data[:attachment] = File.new(File.join("files", "test.jpg"))
	  #data[:attachment] = File.new(File.join("files", "test.txt"))
	  response = RestClient.post "https://api:#{@@private_key}"\
	  "@api.mailgun.net/v2/#{@@domain}/messages", data

	  response = JSON.parse(response)

	end

end
