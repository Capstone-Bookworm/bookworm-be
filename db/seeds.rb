# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do
  User.create(user_name: Faker::Name.name, location: Faker::JapaneseMedia::OnePiece.location, email_address: Faker::Internet.email)
  Book.create(isbn: Faker::Number.number(digits: 10), title: Faker::Book.title, author: Faker::Book.author, image_url: Faker::Internet.url, page_count: Faker::Number.number(digits: 3), summary: Faker::Lorem.sentence(word_count: 10))
end

user_1 = User.first
book_1 = Book.first
user_1.books << book_1

user_2 = User.second
book_2 = Book.second
book_3 = Book.third
user_2.books << [book_2, book_3]

user_3 = User.third
book_4 = Book.fourth
book_5 = Book.fifth
user_3.books << [book_4, book_5]

UserBook.first.update(borrower_id: user_2.id, status: 1)
UserBook.fourth.update(borrower_id: user_3.id, status: 1)

UserBook.second.update(borrower_id: user_3.id, status: 2)

UserBook.third.update(borrower_id: user_3.id, status: 3)