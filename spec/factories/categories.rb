# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end
