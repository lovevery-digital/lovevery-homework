class AddUserFacingIdToChild < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :user_facing_id, :string, unique: true
    # Note: Because there is existing data we can't set null: false
    add_index :children, :user_facing_id
  end
end
