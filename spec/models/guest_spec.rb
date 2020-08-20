require 'rails_helper'

RSpec.describe Guest, type: :model do
  it "requires shipping_name" do
    guest = Guest.new( name: nil )

    expect(guest.valid?).to eq(false)
    expect(guest.errors[:name].size).to eq(1)
  end
end
