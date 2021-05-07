FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email "ramin@example.com"
    password "mammadzada"
  end
end