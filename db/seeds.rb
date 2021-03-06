# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  category = Category.create(title: Faker::Lorem.word, created_by: User.find_by(id:3).id)
  category.products.create(
    name: Faker::Lorem.word,
    price: Faker::Number.decimal(l_digits: 2) ,
    details: Faker::Lorem.sentence(word_count: 5),
  )
end