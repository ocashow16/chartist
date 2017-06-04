class ChangeDates < ActiveRecord::Migration
  def change
    remove_column :stocks, :dates, :datetime
  end
end
