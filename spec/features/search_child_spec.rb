require 'rails_helper'

RSpec.feature "Search", type: :feature do
  
  scenario "Searches for a child and loads the index page with the child set" do
    product = create_product
    child = create_child
    create_order(child, product)
    
    visit "/"
    click_on "Gift Registry"
    
    expect(page).to have_content("Gift Registry")
    
    
    fill_in "child[full_name]", with: child.full_name
    fill_in "child[birthdate]", with: child.birthdate.strftime("%F")
    fill_in "child[parent_name]", with: child.parent_name
    
    click_on "Search"
    
    expect(page).to have_text("Shopping for #{child.full_name}")
    expect(page).not_to have_text("Search for a child in the Gift Registry")
  end
  
  scenario "Searches for a child and fails" do
    visit registry_search_path
    fill_in "child[full_name]", with: "Bad data"
    fill_in "child[birthdate]", with: "Bad data"
    fill_in "child[parent_name]", with: "Bad data"
    
    click_on "Search"
    
    expect(page).to have_text("No children were found.")
  end

  scenario "Searches for a child and loads the product page with the child set" do
    product = create_product
    child = create_child
    create_order(child, product)
    
    visit product_path(product)
    click_on "Gift Registry"
    
    expect(page).to have_content("Gift Registry")
    
    
    fill_in "child[full_name]", with: child.full_name
    fill_in "child[birthdate]", with: child.birthdate.strftime("%F")
    fill_in "child[parent_name]", with: child.parent_name
    
    click_on "Search"
    
    expect(page).to have_text("Shopping for #{child.full_name}")
    expect(page).not_to have_text("Search for a child in the Gift Registry")

    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
  end

end
