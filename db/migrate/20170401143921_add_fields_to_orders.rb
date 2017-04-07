class AddFieldsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :site_id, :integer
    add_column :orders, :post_id, :integer
  end
end
