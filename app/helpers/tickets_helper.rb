module TicketsHelper

	def ticket_status(ticket)
		status = []
		status << ticket.status?
		status << ticket.assigned? unless ticket.assigned?.blank?
		status << ticket.category unless ticket.category.blank?
	end

	def feed_icon(reply)
		reply.agent.blank? ? "feed-item-customer" : "feed-item-agent"
	end

end
