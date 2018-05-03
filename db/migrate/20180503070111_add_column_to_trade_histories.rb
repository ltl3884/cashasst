class AddColumnToTradeHistories < ActiveRecord::Migration
  def change
  	add_column :trade_histories, :vol, :integer
  end
end
