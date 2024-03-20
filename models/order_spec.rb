require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#validations" do
    context 'when valid' do
      subject(:order) { create :order }

      it 'has correct attributes' do
        expect(order).to have_attribute(:product_id, :integer)
        expect(order).to have_attribute(:child_id, :integer)
        expect(order).to have_attribute(:user_facing_id, :string)
        expect(order).to have_attribute(:address, :string)
        expect(order).to have_attribute(:zipcode, :string)
        expect(order).to have_attribute(:paid, :boolean)
        expect(order).to have_attribute(:gift, :boolean)
        expect(order).to have_attribute(:gift_message, :string)
      end
    end

    context 'with invalid attributes' do
      subject(:order) { build :order, shipping_name: nil }

      before { is_expected.to be_invalid }

      it "has shipping_name can't be blank error" do
        expect(order.errors[:shipping_name]).to include "can't be blank"
      end
    end

    context 'with blank attributes' do
      subject(:order) { described_class.new() }

      before { is_expected.to be_invalid }

      it "has product must exist error" do
        expect(order.errors[:product]).to include "must exist"
      end

      it "has child must exist error" do
        expect(order.errors[:child]).to include "must exist"
      end

      it "has shipping_name can't be blank error" do
        expect(order.errors[:shipping_name]).to include "can't be blank"
      end
    end
  end
end
