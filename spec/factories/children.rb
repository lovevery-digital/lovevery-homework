FactoryBot.define do
  factory :child do
    full_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    parent_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    birthdate { 12.months.ago }
  end
end
