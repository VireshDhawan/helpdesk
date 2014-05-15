module ReportsHelper

	def last_30_day
		30.days.ago..Date.today
	end

	def last_month
		prev_month = Date.today.prev_month
	end

	def last_7_days
		date1 = Date.today
		date2 = date1 - 1.week
		date_range = (date2..date1).to_a
	end

end