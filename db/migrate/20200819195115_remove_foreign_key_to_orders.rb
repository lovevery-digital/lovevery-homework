class RemoveForeignKeyToOrders < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :orders, column: :child_id
    remove_index :orders, column: :child_id
  end
end
