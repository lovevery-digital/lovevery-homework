class AddGiftAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :gift, :boolean, default: false
    add_column :orders, :gift_message, :string, nullable: true
  end
end
