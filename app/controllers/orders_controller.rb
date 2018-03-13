class OrdersController < ApplicationController

	def index
		params[:start_date] ||= 7.days.ago.strftime("%Y-%m-%d")
		params[:end_date] ||= Time.now.strftime("%Y-%m-%d")
		@orders = Order.find(params[:symbol], current_user.name, params[:start_date], params[:end_date])
	end

	def cancel
		Order.cancel(params[:id], current_user.name)
		render :nothing => true
	end

end
