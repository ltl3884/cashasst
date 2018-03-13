class Huobi::Account < Huobi::Base
	
	def accounts_info
    path = "/v1/account/accounts"
    request_method = "GET"
    params ={}
    access_huobi(path, params, request_method)
  end

  def balances(account_id)
  	path = "/v1/account/accounts/#{account_id}/balance"
    request_method = "GET"
    access_huobi(path, {}, request_method)
  end

end