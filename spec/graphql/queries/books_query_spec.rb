require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'query books' do
    it 'can query books' do
      user = create(:user)
      pi = create(:book, title: 'Life of Pi')
      one = create(:book, title: 'One Piece')
      man = create(:book, title: 'Chainsaw Man')
      create(:user_book, user_id: user.id, book_id: pi.id)
      create(:user_book, user_id: user.id, book_id: one.id)
      create(:user_book, user_id: user.id, book_id: man.id)

      results = BookwormBeSchema.execute(query)

      expect(results.dig("data", "books")).to be_an Array
      expect(results.dig("data", "books").count).to eq(3)

      book = results.dig("data", "books").first

      expect(book).to have_key("id")
      expect(book).to have_key("isbn")
      expect(book).to have_key("title")
      expect(book).to have_key("author")
      expect(book).to have_key("imageUrl")
      expect(book).to have_key("pageCount")
      expect(book).to have_key("summary")
    end

    it 'queries distinct books' do
      user = create(:user)
      pi = create(:book, title: 'Life of Pi')
      create(:user_book, user_id: user.id, book_id: pi.id)
      create(:user_book, user_id: user.id, book_id: pi.id)

      results = BookwormBeSchema.execute(query)

      expect(results.dig("data", "books")).to be_an Array
      expect(results.dig("data", "books").count).to eq(1)
    end
  end

  def query
    <<~GQL
      query {
        books {
          id
          isbn
          title
          author
          imageUrl
          pageCount
          summary
        }
      }
    GQL
  end
end