class AdminController < ApplicationController

	before_filter :authenticate_agent!
	prepend_before_filter :require_company
	layout "admin_panel"

	def index
		@forwarding_addresses = current_agent.company.forwarding_addresses.count
		@agents = current_agent.company.agents.count
		@groups = current_agent.company.groups.count
		@filters = current_agent.company.filters.count
		@snippets = current_agent.company.snippets.count
		@labels = current_agent.company.labels.count
	end

end
