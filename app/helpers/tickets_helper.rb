module TicketsHelper

	def ticket_status(ticket)
		status = []
		status << ticket.status?
		status << ticket.assigned? unless ticket.assigned?.blank?
		status << ticket.category unless ticket.category.blank?
	end

	def reply_icon(reply)
		reply.agent.blank? ? "feed-item-customer" : "feed-item-agent"
	end

	def table_layout(type)
		if ["spam","trash","all","archived"].include?(type)
			return true
		else
			return false
		end
	end

	def unassigned_count
		current_agent.company.tickets.in_category("Unassigned").count
	end

	def all_count
		current_agent.company.tickets.count
	end

	def agent_count
		current_agent.tickets.count
	end

	def archived_count
		current_agent.company.tickets.in_category("Archived").count
	end

	def spam_count
		current_agent.company.tickets.in_category("Spam").count
	end

	def trash_count
		current_agent.company.tickets.in_category("Trash").count
	end

	def group_count
		current_agent.company.tickets.in_category("Groups").count
	end

	def label_list
		current_agent.company.labels
	end

end
