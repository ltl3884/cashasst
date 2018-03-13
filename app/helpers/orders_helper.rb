module OrdersHelper

	def color_type(type)
		type.include?('卖') ? "text-danger" : "text-success"
	end

	def unit(type)
		type.include?('卖') ? "USDT" : "pts"
	end

	def show_cancle(state)
		if(state == "已提交")
			%q{ <a id="cancel" href="javascript:void(0)">撤销</a> }
		end
	end
end
