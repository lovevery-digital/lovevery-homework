require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "#age_units" do
    it "is 'weeks' for fewer than 13 weeks" do
      product = Product.new(age_low_weeks: 0, age_high_weeks: 12)
      expect(product.age_units).to eq("weeks")
    end

    it "is 'months' for 13 weeks or more" do
      product = Product.new(age_low_weeks: 0, age_high_weeks: 13)
      expect(product.age_units).to eq("months")
    end
  end

  describe "#age_low" do
    it "returns the number of weeks for fewer than 14 weeks" do
      product = Product.new(age_low_weeks: 0, age_high_weeks: 12)
      expect(product.age_low).to eq(0)
    end

    it "returns the number of months for 14 weeks or more" do
      product = Product.new(age_low_weeks: 13, age_high_weeks: 26)
      expect(product.age_low).to eq(3)
    end
  end

  describe "#age_high" do
    it "returns the number of weeks for fewer than 14 weeks" do
      product = Product.new(age_low_weeks: 0, age_high_weeks: 12)
      expect(product.age_high).to eq(12)
    end

    it "returns the number of months for 14 weeks or more" do
      product = Product.new(age_low_weeks: 13, age_high_weeks: 26)
      expect(product.age_high).to eq(6)
    end
  end

  describe '#floating_price' do
    subject(:floating_price) { product.floating_price }

    let(:product) { build :product, price_cents: 999 }

    it 'returns the expected price with floating cents' do
      expect(floating_price).to eq(9.99)
    end
  end

  describe 'commentable model' do
    subject(:product) { create :product }

    it_behaves_like "a commentable model"
  end
end
