module Mutations
  module UserBooks
    class PatchUserBook < Mutations::BaseMutation 
      argument :user_id, Integer, required: true
      argument :book_id, Integer, required: true 
      argument :borrower_id, Integer, required: true
      argument :status, Integer, required: true

      field :success, String, null: false
      
      def resolve(user_id:, book_id:, borrower_id:, status:)
        user_book = UserBook.find_by(user_id: user_id, book_id: book_id)

        if user_book.nil?
          {
            success: 'False'
          }
        else
          user_book.status = status
          user_book.borrower_id = borrower_id
          user_book.save
          {
            success: 'True'
          }
        end
      end
    end
  end
end