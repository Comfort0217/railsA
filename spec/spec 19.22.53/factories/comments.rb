FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user { nil }
    post { nil }
  end
end
