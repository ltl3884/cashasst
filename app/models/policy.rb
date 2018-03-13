class Policy < ActiveRecord::Base
	belongs_to :task
	validates_presence_of :trigger_ratio
	validates_presence_of :change_ratio
	enum change_type: {买: 0, 卖: 1}
	enum triggered: {未触发: 0, 已触发: 1}

	scope :not_triggered, -> { where(triggered: Policy.triggereds['未触发']).order("id") }

	def generate_policy(policy_params)
		self.trigger_ratio = policy_params[:trigger_ratio]
		price = BigDecimal.new(task.standard_price) * BigDecimal.new(trigger_ratio) / BigDecimal.new(100)
		self.trigger_price_float_ratio ||= get_trigger_price_float_ratio
		self.trigger_price_upper = price + price * BigDecimal.new(self.trigger_price_float_ratio) / BigDecimal.new(1000)
		self.trigger_price_lower = price - price * BigDecimal.new(self.trigger_price_float_ratio) / BigDecimal.new(1000)
		self.market_price = price
		self.change_ratio = policy_params[:change_ratio]
		num = get_currency_num(self.task)
		self.change_num = BigDecimal.new(num) * BigDecimal.new(self.change_ratio) / BigDecimal.new(100)
		self.change_type = policy_params[:change_type]
		self
	end

	def get_trigger_price_float_ratio
		AppConfig.instance["trigger_price_float_ratio"]
	end

	def get_currency_num(task)
		spot_id = task.account.spot_id
		account_name = task.account.name
		huobi_account = Huobi::Account.new(account_name)
		balance = huobi_account.balances(spot_id)["data"]["list"].find{|n| Regexp.new("^#{n["currency"]}") =~ task.symbol   }
		balance["balance"]
	end

end
