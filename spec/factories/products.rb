# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { Faker::Lorem.name }
    price { Faker::Lorem.price }
    details { Faker::Lorem.text }
    category_id nil
  end
end