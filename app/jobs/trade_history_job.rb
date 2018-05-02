class TradeHistoryJob < ActiveJob::Base
	
	queue_as :default

	def perform(*args)
		TradeConfig.all.each do |tc|
			market = Huobi::Market.new("liutianlin")
			result = market.history_trade(tc.symbol, tc.size)
			if result["status"] == "ok"
				trend = result["data"].map{|d| d["data"][0]["direction"]}
				trend_result = trend.group_by{|item| item}
				buy = trend_result["buy"].size
				sell = trend_result["sell"].size
				total = buy + sell
				h = TradeHistory.new
				h.symbol = tc.symbol
				h.sell_ratio = ss(sell, total)
				h.buy_ratio = ss(buy, total)
				h.save
			else
			end
		end
	end

	def ss(a, b)
		ratio = (a / b.to_f).round(2)
		format('%.2f', ratio * 100)
	end

end