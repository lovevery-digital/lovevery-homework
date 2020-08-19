class AddOrderableToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :orderable, polymorphic: true, index: true
  end
end
