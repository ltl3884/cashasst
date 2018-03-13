class Huobi::Market < Huobi::Base
	
	def trade_detail(symbol)
    path = "/market/trade"
    request_method = "GET"
    params ={"symbol" => symbol}
    access_huobi(path, params, request_method)
  end

end