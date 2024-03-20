FactoryBot.define do
  factory :comment do
    association(:commentable, factory: :product)
    author_name { Faker::Name.name }
    content { Faker::Lorem.sentence }
  end
end
