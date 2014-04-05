class Company < ActiveRecord::Base

	has_many :agents, dependent: :destroy
	has_one :subscription, :dependent => :destroy

	attr_accessible :name

	validates :name,presence: true
	
end
