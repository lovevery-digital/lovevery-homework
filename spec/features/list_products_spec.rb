require 'rails_helper'

RSpec.feature "List Products", type: :feature do
  scenario "visiting the home page shows all products ordered by age with proper age units" do
    products_in_order = create_products

    visit "/"

    product_nodes = page.all(".products-list .product")
    expect(product_nodes.size).to eq(3)
    expect(product_nodes[0]).to have_text("product1")
    expect(product_nodes[0]).to have_text("0-12 weeks")
    expect(product_nodes[1]).to have_text("product2")
    expect(product_nodes[1]).to have_text("3-4 months")
    expect(product_nodes[2]).to have_text("product3")
    expect(product_nodes[2]).to have_text("5-6 months")

    expect(page).not_to have_text("Shopping for")
    expect(page).to have_text("Search for a child in the Gift Registry")
  end
  
  scenario "visiting the homepage with a valid for uuid displays the name you are shopping for" do
    child = create_child
    
    products_in_order = create_products

    visit "/?for=#{child.user_facing_id}"
    
    expect(page).to have_text("Shopping for #{child.full_name}")
    expect(page).not_to have_text("Search for a child in the Gift Registry")
  end
  
  scenario "visiting the homepage with an invalid for uuid does not display shopping for" do
    products_in_order = create_products

    visit "/?for=baduuidexample"
    
    expect(page).not_to have_text("Shopping for")
    expect(page).to have_text("Search for a child in the Gift Registry")
  end
  
  private
  
  def create_products
    [
      create_product("product1", "description", 100, 0, 12),
      create_product("product2", "description2", 300, 13, 17),
      create_product("product3", "description3", 1200, 21, 26)
    ]
  end
end
