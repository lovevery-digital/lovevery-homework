FactoryBot.define do
  factory :order do
    association(:child)
    association(:product)
    shipping_name { Faker::Name.name }
    address { Faker::Address.street_address }
    zipcode { Faker::Address.zip }
    user_facing_id { SecureRandom.random_number(1_000_000) }
    paid { true }

    trait :gift do
      gift { true }
      gift_message { Faker::Lorem.sentence }
    end
  end
end
