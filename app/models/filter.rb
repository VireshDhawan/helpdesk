class Filter < ActiveRecord::Base

	belongs_to :label
	belongs_to :agent
	belongs_to :group
	belongs_to :company

	attr_accessible :from_email,:delivered_to,:subject_with_keywords,
					:body_with_keywords,:archive,:trash,:spam,:label_id,
					:agent_id,:group_id,:company_id

	validates_format_of :from_email,:delivered_to,:with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :allow_blank => true

end
