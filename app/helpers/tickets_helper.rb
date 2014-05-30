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

	def table_layout(type)
		if ["spam","trash","all","archived"].include?(type)
			return true
		else
			return false
		end
	end

end
