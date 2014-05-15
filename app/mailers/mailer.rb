class Mailer < ActionMailer::Base
  
  	@@private_key = "key-3uwe3fmmable7pzexhhp8fhnt1pkr6d4"
	@@public_key = "pubkey-2065eu46y1g3uvvvu32jbq88iq4ppwm1"
	@@domain = "sandbox43590170d39542e8a97603c1fcd840d1.mailgun.org"

  	def new_ticket_by_agent_mail(ticket)
		#send to the customer
		data = Multimap.new
		data[:from] = "#{ticket.company.name} <#{ticket.reply_email}>"
		data[:to] = "#{ticket.customer_email}"
		data[:subject] = "#{ticket.subject}"
		html_output = render_to_string(template: "mailer/new_ticket_by_agent_mail")
		data[:html] = html_output.to_str
		response = RestClient.post "https://api:#{@@private_key}"\
		"@api.mailgun.net/v2/#{@@domain}/messages", data

		response = JSON.parse(response)
	end

	def unaasigned_tickets_notification(ticket,recipients)
		data = Multimap.new
		data[:from] = "#{ticket.company.name} <#{ticket.company.email}>"
		data[:to] = recipients.join(",")
		data[:subject] = "Unassigned tickets"
		html_output = render_to_string(template: "mailer/unaasigned_tickets_notification")
		data[:html] = html_output.to_str
		response = RestClient.post "https://api:#{@@private_key}"\
		"@api.mailgun.net/v2/#{@@domain}/messages", data

		response = JSON.parse(response)
	end

	def ticket_assigned_to_agent(agent,ticket)
		data = Multimap.new
		data[:from] = "#{agent.company.name} <#{agent.company.email}>"
		data[:to] = "#{agent.email}"
		data[:subject] = "New ticket assigned to you."
		html_output = render_to_string(template: "mailer/ticket_assigned_to_agent",locals: {ticket: ticket})
		data[:html] = html_output.to_str
		response = RestClient.post "https://api:#{@@private_key}"\
		"@api.mailgun.net/v2/#{@@domain}/messages", data

		response = JSON.parse(response)
	end

	def ticket_assigned_to_group(group,ticket,recipients)
		data = Multimap.new
		data[:from] = "#{group.company.name} <#{group.company.email}>"
		data[:to] = recipients.join(",")
		data[:subject] = "New ticket assigned to your group."
		html_output = render_to_string(template: "mailer/ticket_assigned_to_group",locals: {ticket: ticket})
		data[:html] = html_output.to_str
		response = RestClient.post "https://api:#{@@private_key}"\
		"@api.mailgun.net/v2/#{@@domain}/messages", data

		response = JSON.parse(response)
	end

	def new_reply_notification(ticket,reply,recipients)
		data = Multimap.new
		data[:from] = "#{ticket.company.name} <#{ticket.company.email}>"
		data[:to] = recipients.join(",") if recipients.is_a?(Array)
		data[:to] = recipients if recipients.is_a?(String)
		data[:subject] = "New reply on a ticket."
		html_output = render_to_string(template: "mailer/new_reply_notification",locals: {ticket: ticket, reply: reply})
		data[:html] = html_output.to_str
		response = RestClient.post "https://api:#{@@private_key}"\
		"@api.mailgun.net/v2/#{@@domain}/messages", data

		response = JSON.parse(response)
	end

	def new_comment_notification(ticket,comment,recipients)
		data = Multimap.new
		data[:from] = "#{ticket.company.name} <#{ticket.company.email}>"
		data[:to] = recipients.join(",") if recipients.is_a?(Array)
		data[:subject] = "New comment on a ticket."
		html_output = render_to_string(template: "mailer/new_comment_notification",locals: {ticket: ticket, comment: comment})
		data[:html] = html_output.to_str
		response = RestClient.post "https://api:#{@@private_key}"\
		"@api.mailgun.net/v2/#{@@domain}/messages", data

		response = JSON.parse(response)
	end

end
