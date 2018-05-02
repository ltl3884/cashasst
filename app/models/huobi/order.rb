class Huobi::Order < Huobi::Base
	
	def open_orders(symbol, start_date = nil, end_date = nil, side = nil, states = nil)
		side ||= "buy-limit,sell-limit"
		states ||= "pre-submitted,submitted,partial-filled,partial-canceled,filled,canceled"
		start_date ||= 7.days.ago.strftime("%Y-%m-%d")
		end_date ||= Time.now.strftime("%Y-%m-%d")
    params ={
      "symbol" => symbol,
      "types" => side,
      "states" => states,
      "start-date" => start_date,
      "end-date" => end_date
    }
    path = "/v1/order/orders"
    request_method = "GET"
    access_huobi(path, params, request_method)
  end

  def new_order(account_id, symbol, side, price, count)
    params ={
      "account-id" => account_id,
      "amount" => count,
      #"price" => price,
      "source" => "api",
      "symbol" => symbol,
      "type" => side
    }
    path = "/v1/order/orders/place"
    request_method = "POST"
    puts params.to_json
    access_huobi(path, params, request_method)
  end

  def submitcancel(order_id)
    path = "/v1/order/orders/#{order_id}/submitcancel"
    request_method = "POST"
    params ={"order-id" => order_id}
    access_huobi(path,params,request_method)
  end

end