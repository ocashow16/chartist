class CreateReals < ActiveRecord::Migration
  def change
    create_table :reals do |t|
        t.datetime  :dates
        t.time      :times
        t.float     :start_value
        t.float     :high_value
        t.float     :low_value
        t.float     :end_value
      t.timestamps null: false
    end
  end
end
