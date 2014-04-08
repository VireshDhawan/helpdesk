class Plan < ActiveRecord::Base

	attr_accessible :name,:emails,:price,:groups,:agents,:tickets

	has_many :subscriptions

	validates_presence_of :name,:emails,:price,:groups,:agents,:tickets
	validates_uniqueness_of :name

end
