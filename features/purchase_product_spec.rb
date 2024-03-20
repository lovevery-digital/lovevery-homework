require 'rails_helper'

RSpec.feature "Purchase Product", type: :feature do
  context 'when ordering a product' do
    subject(:submit_form) { click_on "Purchase" }

    let!(:product) { create :product }
    let(:last_order) { Order.last }

    before do
      visit root_path

      within ".products-list .product" do
        click_on "More Details…"
      end

      click_on current_button_text

      fill_in "order_form[credit_card_number]", with: "4111111111111111"
      fill_in "order_form[expiration_month]", with: 12
      fill_in "order_form[expiration_year]", with: 25
      fill_in "order_form[child_full_name]", with: "Kim Jones"
      fill_in "order_form[child_birthdate]", with: "2019-03-03"
    end

    context 'as a regular product' do
      let(:current_button_text) { "Buy Now #{number_to_currency(product.floating_price)}" }

      before do
        # Fill in shipping info
        fill_in "order_form[shipping_name]", with: "Pat Jones"
        fill_in "order_form[address]", with: "123 Any St"
        fill_in "order_form[zipcode]", with: 83701
      end

      scenario "Creates an order and charges us" do
        expect { submit_form }.to change(Order, :count).by(1)
                              .and change(Child, :count ).by(1)

        expect(page).to have_content("Thanks for Your Order")
        expect(page).to have_content(last_order.user_facing_id)
        expect(page).to have_content("Kim Jones")
      end
    end

    context 'as a gift' do
      let(:current_button_text) { "Gift Now #{number_to_currency(product.floating_price)}" }

      context 'when child & order exists' do
        let!(:child) { create :child, full_name: "Kim Jones", parent_name: "Pat Jones", birthdate: "2019-03-03" }
        let!(:prev_order) { create :order, child: child, product: product }

        before do
          fill_in "order_form[parent_full_name]", with: "Pat Jones"
          fill_in "order_form[gift_message]", with: "This is a short and sweet msg"
        end

        scenario "Creates an order and charges us" do
          expect { submit_form }.to change{ Order.gifts.count }.by(1)

          expect(page).to have_content("Thanks for Your Order")
          expect(page).to have_content("This is a short and sweet msg")
          expect(page).to have_content(last_order.user_facing_id)
          expect(page).to have_content("Kim Jones")
        end
      end

      context 'when neither child or order exist' do
        scenario "does not create a child" do
          expect { submit_form }.not_to change(Child, :count).from(0)
        end

        scenario "displays validation errors" do
          expect { submit_form }.not_to change(Order, :count).from(0)
          expect(page).to have_content("Child must exist")
        end
      end
    end
  end

  scenario "Tells us when there was a problem charging our card" do
    product = Product.create!(
      name: "product1",
      description: "description2",
      price_cents: 1000,
      age_low_weeks: 0,
      age_high_weeks: 12,
    )

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Buy Now $10.00"

    fill_in "order_form[credit_card_number]", with: "4242424242424242"
    fill_in "order_form[expiration_month]", with: 12
    fill_in "order_form[expiration_year]", with: 25
    fill_in "order_form[shipping_name]", with: "Pat Jones"
    fill_in "order_form[address]", with: "123 Any St"
    fill_in "order_form[zipcode]", with: 83701
    fill_in "order_form[child_full_name]", with: "Kim Jones"
    fill_in "order_form[child_birthdate]", with: "2019-03-03"

    click_on "Purchase"

    expect(page).not_to have_content("Thanks for Your Order")
    expect(page).to have_content("Problem with your order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content("Kim Jones")
  end
end
