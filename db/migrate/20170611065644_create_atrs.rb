class CreateAtrs < ActiveRecord::Migration
  def change
    create_table :atrs do |t|
        t.integer     :high_value_minus_before_end_value
        t.integer     :before_end_value_minus_low_value
        t.integer     :high_value_minus__low_value
        t.integer     :true_range
        t.integer     :average_true_range

      t.timestamps null: false
    end
  end
end
