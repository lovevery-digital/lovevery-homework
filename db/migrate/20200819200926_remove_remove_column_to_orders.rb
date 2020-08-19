class RemoveRemoveColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :child_id
  end
end
