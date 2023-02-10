class UserBook < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum status: %i[available pending_requested unavailable]

  after_destroy :delete_ownerless_books

  private
    
    def delete_ownerless_books
      book = Book.find(self.book_id)
      book.destroy if book.users.empty? 
    end
end
