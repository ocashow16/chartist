class AddColumnTimes2 < ActiveRecord::Migration
  def change
    add_column :atrs, :times, :time
  end
end
