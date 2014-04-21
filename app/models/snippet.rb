class Snippet < ActiveRecord::Base

	belongs_to :snippetable, polymorphic: true

	attr_accessible :name,:content,:tags,:scope

	validates_presence_of :name,:content,:tags
	validates_uniqueness_of :name,scope: [:snippetable_id,:snippetable_type]
	
end
