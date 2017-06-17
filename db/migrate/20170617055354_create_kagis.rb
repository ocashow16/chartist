class CreateKagis < ActiveRecord::Migration
  def change
    create_table :kagis do |t|
        t.integer     :trend
        t.float     :zantei
        t.float     :kakutei
        t.integer     :index
        t.integer     :x
        t.float     :kagi_ashi

      t.timestamps null: false
    end
  end
end
