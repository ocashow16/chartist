class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
        t.string      :stock
        t.integer     :start_value
        t.integer     :high_value
        t.integer     :low_value
        t.integer     :end_value

      t.timestamps null: false
    end
  end
end
Rails.application.database_configuration