class ChangeColumn2 < ActiveRecord::Migration
  def change
    change_column :stocks, :start_value, :decimal
    change_column :stocks, :high_value, :decimal
    change_column :stocks, :low_value, :decimal
    change_column :stocks, :end_value, :decimal
    change_column :stocks, :high_value_minus_before_end_value, :decimal
    change_column :stocks, :before_end_value_minus_low_value, :decimal
    change_column :stocks, :high_value_minus__low_value, :decimal
    change_column :stocks, :true_range, :decimal
    change_column :stocks, :average_true_range, :decimal
  end
end
