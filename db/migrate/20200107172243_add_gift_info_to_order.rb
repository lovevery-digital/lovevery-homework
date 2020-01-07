class AddGiftInfoToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :giver_name, :string
    add_column :orders, :gift_message, :text
  end
end
