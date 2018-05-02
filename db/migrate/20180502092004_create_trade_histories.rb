class CreateTradeHistories < ActiveRecord::Migration
  def change
    create_table :trade_histories do |t|
      t.string :symbol
      t.integer :sell_ratio
      t.integer :buy_ratio

      t.timestamps null: false
    end
    add_index :trade_histories, :created_at
    add_index :trade_histories, :symbol
  end
end
