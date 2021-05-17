FactoryBot.define do
  factory :report do
    description { Faker::Hipster.sentence }
    average_price { rand(100..1000) }
  end
end
