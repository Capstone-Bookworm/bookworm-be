require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'query books' do
    it 'can query books and limits books returned to 20' do
      create_list(:book, 30)

      query = <<~GQL
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

      results = BookwormBeSchema.execute(query)

      expect(results.dig("data", "books")).to be_an Array
      expect(results.dig("data", "books").count).to eq(20)

      book = results.dig("data", "books").first

      expect(book).to have_key("id")
      expect(book).to have_key("isbn")
      expect(book).to have_key("title")
      expect(book).to have_key("author")
      expect(book).to have_key("imageUrl")
      expect(book).to have_key("pageCount")
      expect(book).to have_key("summary")
    end
  end
end