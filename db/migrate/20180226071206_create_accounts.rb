class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
    	t.string :name
    	t.integer :spot_id
    	t.integer :otc_id
    	t.integer :point_id
    	t.string :email
    	t.string :phone_num
      t.timestamps null: false
    end
  end
end
