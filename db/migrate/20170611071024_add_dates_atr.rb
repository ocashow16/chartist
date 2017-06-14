class AddDatesAtr < ActiveRecord::Migration
  def change
    add_column :atrs, :dates, :datetime
  end
end
