module ReportsHelper

	def select_options(action_name)
		if action_name == "agents"
			return Agent.get_list(current_agent.company)
		elsif action_name == "groups"
			return Group.get_list(current_agent.company)
		elsif action_name == "labels"
			return Label.get_list(current_agent.company)
		end
	end

end