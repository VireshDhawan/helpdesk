class TicketCategory < ActiveRecord::Base

	has_many :tickets

	attr_accessible :name

	validate :name, presence: true
	validates_uniqueness_of :name, case_sensitive: false

end
