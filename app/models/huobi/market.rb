class Huobi::Market < Huobi::Base
	
	def trade_detail(symbol)
    path = "/market/trade"
    request_method = "GET"
    params = {"symbol" => symbol}
    access_huobi(path, params, request_method)
  end

  def history_kline(symbol, period, size = 5)
    path = "/market/history/kline"
    request_method = "GET"
    params = {"symbol" => symbol,"period" => period,"size" => size}
    access_huobi(path, params, request_method)
  end

end