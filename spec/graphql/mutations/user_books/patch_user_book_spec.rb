require 'rails_helper'

module Mutations
  module UserBooks
    RSpec.describe PatchUserBook, type: :request do 
      
      before :each do
        @john = create(:user)
        @paul = create(:user)
        @book = create(:book)
        @john.books << @book
      end

      describe '.resolve' do 
        it "updates a UserBook's status" do 
          expect(@john.user_books.first.status).to eq('available')

          post "/graphql", params: { query: happy_query }

          expect(@john.user_books.first.status).to eq('pending_requested')
          result = JSON.parse(response.body, symbolize_names: true)
          expect(result[:data][:patchUserBook][:success]).to eq('True')
        end

        it "returns 'success: false' if given a bad request" do
          expect(@john.user_books.first.status).to eq('available')

          post "/graphql", params: { query: sad_query }

          expect(@john.user_books.first.status).to eq('available')

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result[:data][:patchUserBook][:success]).to eq('False')
        end
      end

      def happy_query
        <<~GQL
          mutation {
            patchUserBook(input: {
                userId: #{@john.id},
                bookId: #{@book.id},
                borrowerId: #{@paul.id},
                status: 1}) 
              {
                success
              }
            }
        GQL
      end
      
      def sad_query
        <<~GQL
          mutation {
            patchUserBook(input: {
                userId: 123456789
                bookId: #{@book.id}
                borrowerId: #{@paul.id}
                status: 1}) 
              {
                success
              }
            }
        GQL
      end
    end
  end
end

