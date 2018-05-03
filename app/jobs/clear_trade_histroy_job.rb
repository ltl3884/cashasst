class ClearTradeHistroyJob < ActiveJob::Base
	
	queue_as :default

	def perform(*args)
		TradeHistory.delete_all(["created_at < ?", Time.now.at_beginning_of_day])
	end

end