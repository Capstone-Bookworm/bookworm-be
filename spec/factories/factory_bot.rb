FactoryBot.define do
  factory :user, class: 'User' do
    user_name { Faker::Name.first_name }
    location { Faker::JapaneseMedia::OnePiece.location }
    email_address { Faker::Internet.email }
  end

  factory :book, class: 'Book' do
    isbn { "#{Faker::Number.number(digits: 10)}" }
    title { Faker::Book.title }
    author { Faker::Book.author }
    image_url { Faker::Lorem.sentence(word_count: 3) }
    page_count { Faker::Number.number(digits: 3) }
    summary { Faker::Lorem.sentence(word_count: 6) }
  end

  factory :user_book, class: 'UserBook' do
    borrower_id { nil }
    status { 0 }
    association :user, factory: :user
    association :book, factory: :book
  end
end