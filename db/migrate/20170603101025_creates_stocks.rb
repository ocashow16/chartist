class CreatesStocks < ActiveRecord::Migration
  def change
    remove_column :stocks, :stock, :string
  end
end
