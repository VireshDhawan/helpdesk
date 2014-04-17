class Label < ActiveRecord::Base

	has_and_belongs_to_many :tickets
	belongs_to :company
	
	attr_accessible :name

	validates_presence_of :name
	validates_uniqueness_of :name, case_insensitive: false

end
