class Company < ActiveRecord::Base

	has_many :agents, dependent: :destroy
	has_one :subscription

	attr_accessible :name
	
end
