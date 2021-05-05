# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    title { Faker::Lorem.word }
  end
end
    