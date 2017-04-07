class AddLockToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_locked, :boolean, default: false
  end
end
