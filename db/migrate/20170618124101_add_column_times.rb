class AddColumnTimes < ActiveRecord::Migration
  def change
    add_column :stocks, :times, :time
  end
end
