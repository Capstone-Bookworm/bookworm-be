module Mutations
  module Books
    class CreateBook < Mutations::BaseMutation
      argument :isbn, String, required: true
      argument :title, String, required: true
      argument :author, String, required: true
      argument :summary, String, required: true
      argument :page_count, Integer, required: true
      argument :image_url, String, required: true

      field :book, Types::BookType, null: false

      def resolve(isbn:, title:, author:, summary:, page_count:, image_url:)
        book = Book.new(isbn: isbn, title: title, author: author, summary: summary, page_count: page_count, image_url: image_url)

        if book.save
          {
            book: book,
            errors: []
          }
        else
          raise GraphQL::ExecutionError, book.errors.full_messages.to_sentence
        end
      end
    end
  end
end