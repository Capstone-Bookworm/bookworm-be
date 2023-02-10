require 'rails_helper'

module Mutations
  module Books
    RSpec.describe DeleteBook, type: :request do 
      describe '.resolve' do 
        it 'deletes a book from only that users library' do 
          # two users, both have a copy of one book
          user = create(:user)
          another_user = create(:user)
          book = create(:book)
          UserBook.create(user: user, book: book)
          UserBook.create(user: another_user, book: book)

          expect(Book.all.length).to eq(1)
          expect(user.books.length).to eq(1)
          expect(another_user.books.length).to eq(1)

          post "/graphql", params: { query: query(user.id, book.id) }

          json_result = JSON.parse(response.body, symbolize_names: true)
          user.reload
          another_user.reload

          expect(json_result[:data][:deleteBook][:success]).to eq("True")
          expect(Book.all.length).to eq(1)
          expect(user.books.length).to eq(0)
          expect(another_user.books.length).to eq(1)
        end

        it 'deletes the book itself if that user was the only owner' do 
          # two users, each have their own book
          user = create(:user)
          another_user = create(:user)
          book = create(:book)
          another_book = create(:book)
          UserBook.create(user: user, book: book)
          UserBook.create(user: another_user, book: another_book)

          expect(Book.all.length).to eq(2)
          expect(user.books.length).to eq(1)

          post "/graphql", params: { query: query(user.id, book.id) }

          json_result = JSON.parse(response.body, symbolize_names: true)
          user.reload
          another_user.reload

          expect(json_result[:data][:deleteBook][:success]).to eq("True")
          expect(Book.all.length).to eq(1)
          expect(user.books.length).to eq(0)
          expect(another_user.books.length).to eq(1)
        end
      end

      def query(user_id, book_id)
        <<~GQL
          mutation {
            deleteBook(
              input: {
                userId: #{user_id}
                bookId: #{book_id}
              }
            ) {
                success
            }
          }
        GQL
      end
    end
  end
end