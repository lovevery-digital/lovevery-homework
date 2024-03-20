require "rails_helper"

RSpec.describe OrderForm, type: :model do
  describe 'validations' do
    subject(:order_form) { described_class.new(order_params) }

    context 'with valid params' do
      let(:product) { create :product }
      let(:order_params) do
        {
          shipping_name: Faker::Name.name,
          child_full_name: Faker::Name.name,
          child_birthdate: "2019-03-03",
          product_id: product.id,
          credit_card_number: Faker::Finance.credit_card(:visa),
          address: Faker::Address.street_address,
          zipcode: Faker::Address.zip_code,
          expiration_year: "2030",
          expiration_month: "05",
          paid: false
        }
      end

      it { is_expected.to be_valid }

      it 'is not a gift' do
        is_expected.not_to be_gift
      end

      it 'has product' do
        expect(order_form.product).to be_present
      end

      it 'finds child' do
        expect(order_form.child).to be_present
      end

      it 'has the correct attributes' do
        is_expected.to have_attribute(:shipping_name)
        is_expected.to have_attribute(:product_id)
        is_expected.to have_attribute(:child_full_name)
        is_expected.to have_attribute(:child_birthdate)
        is_expected.to have_attribute(:credit_card_number)
        is_expected.to have_attribute(:address)
        is_expected.to have_attribute(:zipcode)
        is_expected.to have_attribute(:expiration_year)
        is_expected.to have_attribute(:expiration_month)
        is_expected.to have_attribute(:paid)
        is_expected.to have_attribute(:gift)
        is_expected.to have_attribute(:gift_message)
      end

      context 'while being a gift' do
        let(:order_params) do
          {
            parent_full_name: child.parent_name,
            child_full_name: child.full_name,
            child_birthdate: child.birthdate,
            product_id: product.id,
            gift: true,
            credit_card_number: Faker::Finance.credit_card(:visa),
            expiration_year: "2030",
            expiration_month: "05",
            paid: false
          }
        end

        let(:child) { create :child }
        let(:previous_order) { create :order, child: child, product: product }

        it { is_expected.to be_valid }

        it 'is a gift' do
          is_expected.to be_gift
        end

        it 'has product' do
          expect(order_form.product).to be_present
        end

        it 'finds child' do
          expect(order_form.child).to be_present
        end
      end
    end

    context 'when invalid' do
      context 'while being a gift' do
      end
    end
  end
end
