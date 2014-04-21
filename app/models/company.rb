class Company < ActiveRecord::Base

	has_many :agents, dependent: :destroy
	has_many :groups, dependent: :destroy
	has_many :tickets
	has_many :labels
	has_many :filters
	has_one :subscription, :dependent => :destroy
	has_many :snippets, as: :snippetable

	attr_accessible :name

	validates :name,presence: true
	
end
