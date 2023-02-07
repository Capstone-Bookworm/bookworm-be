require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'query book' do
    it 'can query a single book' do
      create_list(:book, 4)
      book = create(:book, id: 5, isbn: "9780307885166", title: "A Short History Of Nearly Everything", author: "Bill Bryson", image_url: "url", page_count: 876, summary: "This new edition")

      query = <<~GQL
        query {
          book(id:5) {
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
      
      result = BookwormBeSchema.execute(query)

      expect(result.dig("data", "book", "id")).to eq(String(5))
      expect(result.dig("data", "book", "isbn")).to eq("9780307885166")
      expect(result.dig("data", "book", "title")).to eq("A Short History Of Nearly Everything")
      expect(result.dig("data", "book", "author")).to eq("Bill Bryson")
      expect(result.dig("data", "book", "imageUrl")).to eq("url")
      expect(result.dig("data", "book", "pageCount")).to eq(876)
      expect(result.dig("data", "book", "summary")).to eq("This new edition")
    end
  end
end