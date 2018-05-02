class CreateTradeConfigs < ActiveRecord::Migration
  def change
    create_table :trade_configs do |t|
      t.string :symbol
      t.integer :size
      t.integer :ratio

      t.timestamps null: false
    end
  end
end
