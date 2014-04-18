module CompaniesHelper

	def authorize_company_privilages_in_view
		current_agent.allow_company_management ? true : false
	end

end
