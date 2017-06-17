class RemoveColumnsFromStocks < ActiveRecord::Migration
  def change
    remove_column :stocks, :high_value_minus_before_end_value, :float
    remove_column :stocks, :before_end_value_minus_low_value, :float
    remove_column :stocks, :high_value_minus__low_value, :float
    remove_column :stocks, :true_range, :float
    remove_column :stocks, :average_true_range, :float
  end
end
