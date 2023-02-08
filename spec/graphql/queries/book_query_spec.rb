require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'query book' do
    it 'can query a single book' do
      short_history = create(:book, id: 5)
      user = create(:user)
      borrower = create(:user)
      user.books << short_history
      UserBook.first.update(borrower_id: borrower.id)

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
            borrower {
              userName
            }
            users {
              userName
            }
          }
        }
      GQL
      
      result = BookwormBeSchema.execute(query).to_json
      json = JSON.parse(result, symbolize_names: true)
      
      expect(json[:data][:book][:id]).to be_a String
      expect(json[:data][:book][:isbn]).to be_a String
      expect(json[:data][:book][:title]).to be_a String
      expect(json[:data][:book][:author]).to be_a String
      expect(json[:data][:book][:imageUrl]).to be_a String
      expect(json[:data][:book][:pageCount]).to be_an Integer
      expect(json[:data][:book][:summary]).to be_a String
      expect(json[:data][:book][:borrower]).to be_a Hash
      expect(json[:data][:book][:borrower][:userName]).to be_a String
      expect(json[:data][:book][:users]).to be_an Array
    end

    it 'returns an empty object if there is no borrower' do
      short_history = create(:book, id: 5, isbn: "9780307885166", title: "A Short History Of Nearly Everything", author: "Bill Bryson", image_url: "url", page_count: 876, summary: "This new edition")
      user = create(:user)
      user.books << short_history

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
            borrower {
              userName
            }
            users {
              userName
            }
          }
        }
      GQL
      
      result = BookwormBeSchema.execute(query).to_json
      json = JSON.parse(result, symbolize_names: true)

      expect(json[:data][:book][:borrower]).to be_a Hash
      expect(json[:data][:book][:borrower][:userName]).to be nil
    end
  end
end