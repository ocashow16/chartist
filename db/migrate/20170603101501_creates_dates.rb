class CreatesDates < ActiveRecord::Migration
  def change
    add_column :stocks, :dates, :datetime
  end
end
