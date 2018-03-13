class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.integer :task_id, index: true
      t.decimal :trigger_price_upper, :precision => 19, :scale => 4
      t.decimal :trigger_price_lower, :precision => 19, :scale => 4
      t.integer :trigger_price_float_ratio
      t.integer :trigger_ratio
      t.decimal :market_price, :precision => 19, :scale => 4
      t.decimal :change_num, :precision => 19, :scale => 4
      t.integer :change_ratio
      t.integer :change_type
      t.integer :triggered, :default => 0
      t.timestamps null: false
    end
  end
end
