module AccountsHelper

	def color(status)
		status == 1 ? "text-success" : "text-danger"
	end
end
