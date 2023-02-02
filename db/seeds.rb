# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do
  User.create(user_name: Faker::Name.name, location: Faker::Name.name, email_address: Faker::Name.name)
  Book.create(isbn: Faker::Name.name, title: Faker::Name.name, author: Faker::Name.name, image_url: Faker::Name.name, page_count: 10, summary: Faker::Name.name)
end

user = User.first
book = Book.first

user.books << book