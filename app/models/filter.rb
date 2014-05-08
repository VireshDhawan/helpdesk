class Filter < ActiveRecord::Base

	belongs_to :label
	belongs_to :agent
	belongs_to :group
	belongs_to :company

	attr_accessible :from_email,:delivered_to,:subject_with_keywords,
					:body_with_keywords,:archive,:trash,:spam,:label_id,
					:agent_id,:group_id,:company_id

	validates_format_of :from_email,:delivered_to,:with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :allow_blank => true

	# Check if a filter exists for a address
	# If yes then return the filter or return nil
	# also can get company from the returned filter
	def self.check_filter_for_address(address)
		Filter.find_by(delivered_to: address)
	end

	## ** ONLY FOR TICKET CREATED BY SYSTEM NOT API ** ##
	# returns a filter if the ticket matches to 
	# a defined company filter
	def self.get_matching_filter(company,ticket)
		#if from email
		company.filters.select{|f| (
			f.from_email == ticket.customer_email ||
			f.delivered_to == ticket.reply_to
			# and subject with keywords
			# and body with keywords
			)
		}
	end

end
