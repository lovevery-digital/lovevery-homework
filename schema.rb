# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_03_13_180145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", force: :cascade do |t|
    t.string "full_name", null: false, comment: "The child's full name"
    t.date "birthdate", null: false, comment: "This child's birthdate or expecting date"
    t.string "parent_name", null: false, comment: "The full name of the child's parent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["full_name", "birthdate", "parent_name"], name: "index_children_on_full_name_and_birthdate_and_parent_name", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "author_name"
    t.text "content"
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "user_facing_id", null: false, comment: "A user-facing ID we can give the user to track their order in our system"
    t.bigint "product_id", null: false, comment: "What product is this order for?"
    t.bigint "child_id", null: false, comment: "Which child is this for?"
    t.string "shipping_name", null: false, comment: "Name of who we are shipping to"
    t.string "address", null: false, comment: "Street Address for shipping"
    t.string "zipcode", null: false, comment: "Zip Code for shipping"
    t.boolean "paid", null: false, comment: "True if this order has been paid via a successful charge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "gift", default: false
    t.string "gift_message"
    t.index ["child_id"], name: "index_orders_on_child_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", comment: "Product catalog", force: :cascade do |t|
    t.string "name", null: false, comment: "The name of the product"
    t.text "description", null: false, comment: "Longer description of the product"
    t.integer "price_cents", null: false, comment: "Retail price, in cents, of the product"
    t.integer "age_low_weeks", null: false, comment: "Lowest appropriate age for this product, in weeks"
    t.integer "age_high_weeks", null: false, comment: "Highest appropriate age for this product, in weeks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "orders", "children"
  add_foreign_key "orders", "products"
end
