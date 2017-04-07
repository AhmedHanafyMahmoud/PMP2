class AddPriceToSite < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :price, :integer
  end
end
