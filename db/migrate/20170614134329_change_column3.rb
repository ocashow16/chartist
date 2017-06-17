class ChangeColumn3 < ActiveRecord::Migration
  def change
    change_column :stocks, :start_value, :float
    change_column :stocks, :high_value, :float
    change_column :stocks, :low_value, :float
    change_column :stocks, :end_value, :float
    change_column :stocks, :high_value_minus_before_end_value, :float
    change_column :stocks, :before_end_value_minus_low_value, :float
    change_column :stocks, :high_value_minus__low_value, :float
    change_column :stocks, :true_range, :float
    change_column :stocks, :average_true_range, :float
  end
end
