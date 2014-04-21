module FiltersHelper

	def filter_labels
		current_agent.company.labels.pluck(:name,:id)	
	end

	def filter_groups
		current_agent.company.groups.pluck(:name,:id)	
	end

	def filter_agents
		current_agent.company.agents.select([:first_name,:last_name,:id]).map {|e| ["#{e.first_name} #{e.last_name}",e.id]}
	end

end
