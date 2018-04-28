class UpdateMa5Job < ActiveJob::Base
	
	queue_as :default

	def perform(*args)
		Task.running.each do |task|
			task.policies.not_triggered.each do |policy|
				if policy[:is_ma5] == 1
					price = ma5_price(policy.task)
					policy.market_price = price
					policy.trigger_price_upper = price + price * BigDecimal.new(policy.trigger_price_float_ratio) / BigDecimal.new(1000)
					policy.trigger_price_lower = price - price * BigDecimal.new(policy.trigger_price_float_ratio) / BigDecimal.new(1000)
					policy.save
					LOG.info "policy更新ma5,price:#{price} #{policy.trigger_price_lower}-#{policy.trigger_price_upper}"
				end
			end
		end
	end

	def ma5_price(task)
		market = Huobi::Market.new(task.account.name)
		kline = market.history_kline(task.symbol, "1day")
		kline["data"].map{|d| d["close"]}.reduce(:+)/5
	end

end