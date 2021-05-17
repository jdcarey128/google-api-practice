FactoryBot.define do
  factory :item do
    name { Faker::FunnyName.name }
    description { Faker::Hipster.sentence }
    unit_price { rand(10..100) }
    merchant_id { rand(1..15) }
    school { Faker::FunnyName.name }
  end
end
