class ChangeColumnsInAtrs < ActiveRecord::Migration
  def change
    change_column :atrs, :high_value_minus_before_end_value, :float
    change_column :atrs, :before_end_value_minus_low_value, :float
    change_column :atrs, :high_value_minus__low_value, :float
    change_column :atrs, :true_range, :float
    change_column :atrs, :average_true_range, :float
  end
end
