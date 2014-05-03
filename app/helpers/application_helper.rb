module ApplicationHelper

	def send_simple_message
	  RestClient.post "https://api:key-3uwe3fmmable7pzexhhp8fhnt1pkr6d4"\
	  "@api.mailgun.net/v2/sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org/messages",
	  :from => "Helpdesk <postmaster@sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org>",
	  :to => "xmpirate.m@gmail.com",
	  :subject => "Hello",
	  :text => "Testing some Mailgun awesomness!"
	end

end
