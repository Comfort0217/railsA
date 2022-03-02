FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    user { nil }
  end
end
