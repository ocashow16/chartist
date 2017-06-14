class AddAtrStock < ActiveRecord::Migration
  def change
add_column :stocks, :high_value_minus_before_end_value, :integer
add_column :stocks, :before_end_value_minus_low_value, :integer
add_column :stocks, :high_value_minus__low_value, :integer
add_column :stocks, :true_range, :integer
add_column :stocks, :average_true_range, :integer
  end
end
