class Label < ActiveRecord::Base

	has_and_belongs_to_many :tickets
	belongs_to :company
	
	attr_accessible :name,:company_id,:color

	validates :name, presence: true, uniqueness: {scope: :company_id, case_insensitive: false, message: "label with the name already exists."}
	validates :color, presence: true, uniqueness: {scope: :company_id, message: "label with the color already exists."}


	def self.get_list(company)
		company.labels.collect{ |l| [l.name, l.id] }
	end

end
