class Policy < ActiveRecord::Base
	belongs_to :task
	validates_presence_of :trigger_ratio
	validates_presence_of :change_ratio
	enum change_type: {买: 0, 卖: 1}
	enum triggered: {未触发: 0, 已触发: 1}
	enum is_ma5: {否: '0', 是: '1'}

	scope :not_triggered, -> { where(triggered: Policy.triggereds['未触发']).order("id") }

	def calc_policy(policy_params)
		self.trigger_ratio = policy_params[:trigger_ratio]
		price = 0
		if policy_params[:is_ma5].to_i == 0
			price = BigDecimal.new(task.standard_price) * BigDecimal.new(trigger_ratio) / BigDecimal.new(100)
		else
			price = ma5_price(self.task)
		end
		self.trigger_price_float_ratio ||= get_trigger_price_float_ratio
		self.trigger_price_upper = price + price * BigDecimal.new(self.trigger_price_float_ratio) / BigDecimal.new(1000)
		self.trigger_price_lower = price - price * BigDecimal.new(self.trigger_price_float_ratio) / BigDecimal.new(1000)
		self.market_price = price
		self.change_ratio = policy_params[:change_ratio]
		num = get_currency_num(self.task)
		self.change_num = policy_params[:change_num].to_i.zero? ? BigDecimal.new(num) * BigDecimal.new(self.change_ratio) / BigDecimal.new(100) : policy_params[:change_num]
		self.change_type = policy_params[:change_type]
		self.is_ma5 = policy_params[:is_ma5].to_i
		self
	end

	def get_trigger_price_float_ratio
		AppConfig.instance["trigger_price_float_ratio"]
	end


	def ma5_price(task)
		market = Huobi::Market.new(task.account.name)
		kline = market.history_kline(task.symbol, "1day")
		kline["data"].map{|d| d["close"]}.reduce(:+)/5
	end

	def get_currency_num(task)
		spot_id = task.account.spot_id
		account_name = task.account.name
		huobi_account = Huobi::Account.new(account_name)
		balance = huobi_account.balances(spot_id)["data"]["list"].find{|n| Regexp.new("^#{n["currency"]}") =~ task.symbol   }
		balance["balance"]
	end

end
