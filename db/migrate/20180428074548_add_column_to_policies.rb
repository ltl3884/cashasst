class AddColumnToPolicies < ActiveRecord::Migration
  def change
  	add_column :policies, :is_ma5, :integer, :default => 0
  end
end
