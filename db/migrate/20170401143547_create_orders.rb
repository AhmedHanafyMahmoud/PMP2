class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :period
      t.date :start_date
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
