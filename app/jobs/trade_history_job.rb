class TradeHistoryJob < ActiveJob::Base
	
	queue_as :default

	def perform(*args)
		TradeConfig.all.each do |tc|
			market = Huobi::Market.new("liutianlin")
			result = market.history_trade(tc.symbol, tc.size)
			kline_result = market.history_kline(tc.symbol, "5min", 1)
			if result["status"] == "ok" and kline_result["status"] == "ok"
				trend = result["data"].map{|d| d["data"][0]["direction"]}
				trend_result = trend.group_by{|item| item}
				buy = trend_result["buy"].size
				sell = trend_result["sell"].size
				total = buy + sell
				h = TradeHistory.new
				h.symbol = tc.symbol
				h.sell_ratio = ss(sell, total)
				h.buy_ratio = ss(buy, total)
				h.vol = kline_result["data"][0]["vol"].to_i
				h.save
				LOG.info "创建#{tc.symbol}交易数据"
			else
				LOG.info "获取#{tc.symbol}交易数据错误  #{result['err-msg']}"
			end
		end
	end

	def ss(a, b)
		ratio = (a / b.to_f).round(2)
		format('%.2f', ratio * 100)
	end

end