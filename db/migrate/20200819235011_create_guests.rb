class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :name, null: false, comment: "The full name of the child's guest"
      t.references :child, null: false, foreign_key: true, comment: "Which child is this for?"
      t.timestamps
    end
  end
end
