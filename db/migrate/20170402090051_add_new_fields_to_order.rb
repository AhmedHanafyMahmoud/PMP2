class AddNewFieldsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :frequency, :integer
    add_column :orders, :total_price, :integer
    add_column :orders, :status, :string
  end
end
