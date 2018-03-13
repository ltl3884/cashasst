module PoliciesHelper

	def get_currency_num(task_id)
		task = Task.find_by_id(task_id)
		spot_id = task.account.spot_id
		account_name = task.account.name
		huobi_account = Huobi::Account.new(account_name)
		result = huobi_account.balances(spot_id)
		if result["status"] == 'ok'
			balance = result["data"]["list"].find{|n| Regexp.new("^#{n["currency"]}") =~ task.symbol   }
			BigDecimal.new(balance["balance"]).ceil(2)
		else
			return result["err-msg"]
		end
		
	end

	def color(change_type)
		change_type == 1 ? "text-danger" : "text-success"
	end

end
