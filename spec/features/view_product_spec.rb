require 'rails_helper'

RSpec.feature "View Product", type: :feature do
  scenario "Shows the product description and price" do
    product = create_product

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    expect(page).to have_content("description2")
    expect(page).to have_content("$10.00")
    expect(page).not_to have_text("Shopping for")
    expect(page).to have_text("Search for a child in the Gift Registry")
  end
  
  scenario "Shows who you are shopping for when there is a valid for uuid" do
    create_product
    child = create_child

    visit "/?for=#{child.user_facing_id}"

    within ".products-list .product" do
      click_on "More Details…"
    end

    expect(page).to have_text("Shopping for #{child.full_name}")
    expect(page).not_to have_text("Search for a child in the Gift Registry")
  end
  
  scenario "Does not display shopping for but still loads when there is an invalid for uuid" do
    create_product

    visit "/?for=baduuidexample"

    within ".products-list .product" do
      click_on "More Details…"
    end

    expect(page).not_to have_text("Shopping for")
    expect(page).to have_text("Search for a child in the Gift Registry")
  end
  
end
