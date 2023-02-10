module Mutations
  module Books
    class DeleteBook < Mutations::BaseMutation
      argument :book_id, ID, required: true
      argument :user_id, ID, required: true

      field :success, String, null: false
      
      def resolve(book_id:, user_id:)
        user_book = UserBook.find_by(book_id: book_id, user_id: user_id)

        if user_book.nil?
          raise GraphQL::ExecutionError, 'Record with the provided user_id and book_id not found'
        else
          user_book.destroy
          {
            success: "True"
          }
        end
      end
    end
  end
end