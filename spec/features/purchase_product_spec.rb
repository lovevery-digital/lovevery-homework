require 'rails_helper'

RSpec.feature "Purchase Product", type: :feature do
  scenario "Creates an order and charges us" do
    product = create_product
    child_count = Child.count

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Buy Now $10.00"

    fill_base_order_details
    fill_in "order[credit_card_number]", with: "4111111111111111"

    click_on "Purchase"

    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content("Kim Jones")
    expect(page).to have_content("To place future orders that ship direct to Kim Jones use this link")
    expect(Child.count).to eq(child_count + 1)
  end

  scenario "Creates an order and charges us with gift information" do
    product = create_product
    child_count = Child.count

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Buy Now $10.00"

    fill_base_order_details
    fill_in "order[credit_card_number]", with: "4111111111111111"
    fill_in "order[giver_name]", with: "Mary Smith"
    fill_in "order[gift_message]", with: "Happy Birthday from Aunt Mary!"

    click_on "Purchase"

    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content("Kim Jones")
    expect(page).to have_content("To place future orders that ship direct to Kim Jones use this link")
    expect(Child.count).to eq(child_count + 1)
  end

  scenario "Tells us when there was a problem charging our card" do
    product = create_product

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Buy Now $10.00"

    fill_base_order_details
    fill_in "order[credit_card_number]", with: "4242424242424242"

    click_on "Purchase"

    expect(page).not_to have_content("Thanks for Your Order")
    expect(page).to have_content("Problem with your order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content("Kim Jones")    
  end

  scenario "Use a previous child when their for uuid is provided" do
    product = create_product
    child = create_child
    create_order(child, product)
    child_count = Child.count
    order_count = Order.count

    visit "/?for=#{child.user_facing_id}"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Buy Now $10.00"
    
    fill_in "order[credit_card_number]", with: "4111111111111111"
    fill_in "order[expiration_month]", with: 12
    fill_in "order[expiration_year]", with: 25
    fill_in "order[giver_name]", with: "Mary Smith"
    fill_in "order[gift_message]", with: "Happy Birthday from Aunt Mary!"

    click_on "Purchase"
    
    expect(Child.count).to eq(child_count)
    expect(Order.count).to eq(order_count + 1)
    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content(child.full_name)
    expect(page).to have_content("To place future orders that ship direct to #{child.full_name} use this link")
  end

  private
  
  def fill_base_order_details
    fill_in "order[expiration_month]", with: 12
    fill_in "order[expiration_year]", with: 25
    fill_in "order[shipping_name]", with: "Pat Jones"
    fill_in "order[address]", with: "123 Any St"
    fill_in "order[zipcode]", with: 83701
    fill_in "order[child_full_name]", with: "Kim Jones"
    fill_in "order[child_birthdate]", with: "2019-03-03"
  end
end
