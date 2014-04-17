class Group < ActiveRecord::Base

	belongs_to :company
	has_many :groups_agents, :class_name => "GroupsAgents"
	has_many :agents, :through => :groups_agents
	has_many :tickets

	attr_accessible :name,:company_id

	validates_presence_of :name,:company_id
	validates_uniqueness_of :name, :case_sensitive => false, message: "Group with the given name already exists."
	
end
