require 'rails_helper'

module Mutations
  module Books
    RSpec.describe CreateBook, type: :request do
      describe '.resolve' do
        it 'creates a book' do
          expect(Book.count).to eq(0)

          post "/graphql", params: { query: book_happy_query }

          expect(Book.count).to eq(1)
        end

        it 'returns a Book' do
          post "/graphql", params: { query: book_happy_query }

          json = JSON.parse(response.body, symbolize_names: true)
          book = json[:data][:createBook][:book]

          expect(book[:isbn]).to eq("1784752223")
          expect(book[:title]).to eq("Jurassic Park")
          expect(book[:author]).to eq("Michael Crichton")
          expect(book[:pageCount]).to eq(480)
          expect(book[:summary]).to eq("summary")
          expect(book[:imageUrl]).to eq("http://books.google.com/books/content?id=uo7TsgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api")
          expect(book).to have_key(:id)
        end

        it 'returns an error if attributes are missing' do
          post "/graphql", params: { query: sad_query_missing_attrs }

          json = JSON.parse(response.body, symbolize_names: true)

          expect(json[:data][:createBook]).to be_nil
          expect(json[:errors][0][:message]).to eq("Title can't be blank and Author can't be blank")
        end

        it 'returns an error if isbn is not unique' do
          post "/graphql", params: { query: book_happy_query }
          post "/graphql", params: { query: sad_query_not_uniq_isbn }

          json = JSON.parse(response.body, symbolize_names: true)

          expect(json[:data][:createBook]).to be_nil
          expect(json[:errors][0][:message]).to eq("Isbn has already been taken")
        end
      end
    end
  end
end

def book_happy_query
  <<~GQL
    mutation {
      createBook(
        input: {
          isbn: "1784752223"
          title: "Jurassic Park"
          author: "Michael Crichton"
          pageCount: 480
          summary: "summary"
          imageUrl: "http://books.google.com/books/content?id=uo7TsgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
        }
      ) {
          book {
          id
          isbn
          title
          author
          pageCount
          summary
          imageUrl
        }
      }
    }
  GQL
end

def sad_query_missing_attrs
  <<~GQL
    mutation {
      createBook(
        input: {
          isbn: "1784752223"
          title: ""
          author: ""
          pageCount: 480
          summary: "summary"
          imageUrl: "http://books.google.com/books/content?id=uo7TsgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
        }
      ) {
          book {
          id
          isbn
          title
          author
          pageCount
          summary
          imageUrl
        }
      }
    }
  GQL
end

def sad_query_not_uniq_isbn
  <<~GQL
    mutation {
      createBook(
        input: {
          isbn: "1784752223"
          title: "Jurassic Park II"
          author: "Michael Crichton"
          pageCount: 480
          summary: "summary"
          imageUrl: "http://books.google.com/books/content?id=uo7TsgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
        }
      ) {
          book {
          id
          isbn
          title
          author
          pageCount
          summary
          imageUrl
        }
      }
    }
  GQL
end