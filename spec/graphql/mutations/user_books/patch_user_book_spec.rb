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
        end

        it "returns an error if given a bad request" do
          expect(@john.user_books.first.status).to eq('available')

          post "/graphql", params: { query: sad_query }

          expect(@john.user_books.first.status).to eq('available')

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result[:data][:patchUserBook][:error]).to eq('Record with the provided user_id and book_id not found')
        end

        it "sets the borrower_id to nil if the book is returned" do
          expect(@john.user_books.first.status).to eq('available')

          post "/graphql", params: { query: return_query }

          expect(@john.user_books.first.status).to eq('available')
          expect(@john.user_books.first.borrower_id).to eq(nil)
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
                userBook {
                  bookId
                }
              }
            }
        GQL
      end

      def return_query
        <<~GQL
          mutation {
            patchUserBook(input: {
                userId: #{@john.id},
                bookId: #{@book.id},
                borrowerId: #{@paul.id},
                status: 0}) 
              {
                userBook {
                  bookId
                }
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
                error
              }
            }
        GQL
      end
    end
  end
end

