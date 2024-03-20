require 'rails_helper'

RSpec.feature "Comment Product", type: :feature do
  subject(:submit_form) { click_on "Submit" }

  let!(:product) do
    create :product, description: "description2", price_cents: 1000
  end

  before do
    visit product_path(product)
    expect(page).to have_content("description2")
    expect(page).to have_content("$10.00")
  end

  context 'when creating a comment with author_name' do
    it "creates a new comment linked to product" do
      fill_in "comment[author_name]", with: "John Doe"
      fill_in "comment[content]", with: "Lorem ip sum"
      expect { submit_form }.to change(Comment, :count).by(1)
      expect(page).to have_content("John Doe")
      expect(page).to have_content("Lorem ip sum")
    end
  end

  context 'when creating a comment without author_name' do
    it "creates a new comment linked to product" do
      fill_in "comment[content]", with: "Lorem ip sum"
      expect { submit_form }.to change(Comment, :count).by(1)
      expect(page).to have_content("Unknown")
      expect(page).to have_content("Lorem ip sum")
    end
  end

  context 'when creating a comment without content' do
    it "Prevents comment creation & displays validation error" do
      fill_in "comment[author_name]", with: "John Doe"
      expect { submit_form }.not_to change(Comment, :count).from(0)
      expect(page).to have_content("Content can't be blank")
    end
  end
end
