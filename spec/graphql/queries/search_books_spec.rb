require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'query books with a search' do
    it 'can query books based on a search' do
      create_list(:book, 1, title: 'Life of Pi')
      create_list(:book, 23, title: 'Diary of a Wimpy Kid')
    
      query = <<~GQL
        query {
          bookSearch(title: "Pi") {
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
      expect(results.dig("data", "bookSearch").count).to eq(1)

      expect(results.dig("data", "bookSearch")[0]["title"]).to eq('Life of Pi')
    end

    it 'limits the search to 20' do
      create_list(:book, 26, title: 'Jurassic Park')
      
      query = <<~GQL
        query {
          bookSearch(title: "Jurassic Park") {
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

      expect(results.dig("data", "bookSearch")).to be_an Array
      expect(results.dig("data", "bookSearch").count).to eq(20)
    end

    it 'returns an empty array if there are no books by that search' do
      create_list(:book, 26, title: 'Jurassic Park')
      
      query = <<~GQL
        query {
          bookSearch(title: "Hello World") {
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

      expect(results.dig("data", "bookSearch")).to eq([])
    end
  end
end