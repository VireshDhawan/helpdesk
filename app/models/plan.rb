class Plan < ActiveRecord::Base

	attr_accessible :name,:emails,:price,:groups,:agents,:tickets

	has_many :subscriptions

	validates_presence_of :name,:emails,:price,:groups,:agents,:tickets
	validates_uniqueness_of :name, :case_sensitive => false

	validates_numericality_of :price,:greater_than_or_equal_to => 0
	validates_numericality_of :emails,:greater_than_or_equal_to => -1
	validates_numericality_of :agents,:greater_than_or_equal_to => -1
	validates_numericality_of :groups,:greater_than_or_equal_to => -1
	validates_numericality_of :tickets,:greater_than_or_equal_to => -1

end
