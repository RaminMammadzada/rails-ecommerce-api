# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    price { Faker::Number.decimal(l_digits: 2) }
    details { Faker::Lorem.sentence(word_count: 5) }
    category_id nil
  end
end
