class GroupsAgents < ActiveRecord::Base

	belongs_to :group
	belongs_to :agent

	attr_accessible :group_id,:agent_id
	
end
