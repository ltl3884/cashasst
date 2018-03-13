class Order

	TYPES = {'buy-limit' => '限价买', 'sell-limit' => '限价卖', 'buy-market' => '市价买', 'sell-market' => '市价卖'}
	STATE = {'pre-submitted' => '准备提交', 'submitted' => '已提交', 'partial-filled' => '部分成交', 'partial-canceled' => '部分成交撤销', 'filled' => '完全成交', 'canceled' => '已撤销'}

	attr_accessor :order_id, :created_at, :symbol, :type, :price, :amount, :total, :field_amount, :field_fees, :state

	def self.find(symbol, account_name, start_date, end_date)
		return [] if symbol.blank?
		huobi_order = Huobi::Order.new(account_name)
		huobi_orders = huobi_order.open_orders(symbol, start_date, end_date)
		huobi_orders["status"] == "ok" ? transform(huobi_orders["data"]) : []
	end

	def self.cancel(order_id, account_name)
		huobi_order = Huobi::Order.new(account_name)
		huobi_order.submitcancel(order_id)
	end
	
	private
	def self.transform huobi_orders
		orders = []
		huobi_orders.each do |horder|
			order = Order.new
			order.order_id = horder["id"]
			order.created_at = Time.at(horder["created-at"]/1000).to_s(:db)
			order.symbol = horder["symbol"]
			order.type = TYPES[horder["type"]]
			order.price = BigDecimal.new(horder["price"]).ceil(2)
			order.amount = BigDecimal.new(horder["amount"]).ceil(2)
			order.total = (order.price * order.amount).ceil(2)
			order.field_amount = BigDecimal.new(horder["field-amount"]).ceil(2)
			order.field_fees = BigDecimal.new(horder["field-fees"]).ceil(4)
			order.state = STATE[horder["state"]]
			orders << order
		end
		orders
	end
end