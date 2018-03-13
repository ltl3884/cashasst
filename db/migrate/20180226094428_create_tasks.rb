class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :symbol
      t.integer :status, default: 0
      t.decimal :standard_price, :precision => 19, :scale => 4
      t.integer :account_id, index: true

      t.timestamps null: false
    end
  end
end
