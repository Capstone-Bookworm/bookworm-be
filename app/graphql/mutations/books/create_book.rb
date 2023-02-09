module Mutations
  module Books
    class CreateBook < Mutations::BaseMutation
      argument :isbn, String, required: true
      argument :title, String, required: true
      argument :author, String, required: true
      argument :summary, String, required: true
      argument :page_count, Integer, required: true
      argument :image_url, String, required: true
      argument :user_id, ID, required: true

      field :book, Types::BookType, null: false
      
      def resolve(isbn:, title:, author:, summary:, page_count:, image_url:, user_id:)
        book = Book.find_by(isbn: isbn)
        if book.nil?
          book = Book.new(isbn: isbn, title: title, author: author, summary: summary, page_count: page_count, image_url: image_url)
        end
        raise GraphQL::ExecutionError, book.errors.full_messages.to_sentence if !book.save 
        UserBook.create(user_id: user_id.to_i, book_id: book.id)
      end
    end
  end
end