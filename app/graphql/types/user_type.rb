# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :user_name, String
    field :location, String
    field :email_address, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :available_books, [Types::BookType], null: false

    def available_books
      Book
        .joins(:user_books)
        .where("user_books.user_id = #{object.id}")
        .where("user_books.status = 0")
    end

    field :pending_requested, [Types::BookType], null: false

    def pending_requested
      Book.joins(:user_books)
        .where("user_books.user_id = #{object.id}")
        .where("user_books.status = 1")
        .select("books.*, user_books.user_id")
    end

    field :pending_returned, [Types::BookType], null: false

    def pending_returned
      Book.joins(:user_books)
        .where("user_books.user_id = #{object.id}")
        .where("user_books.status = 2")
        .select("books.*, user_books.user_id")
    end

    field :unavailable_books, [Types::BookType], null: false

    def unavailable_books
      Book.joins(:user_books)
        .where("user_books.user_id = #{object.id}")
        .where("user_books.status = 3")
        .select("books.*, user_books.user_id")
    end

    field :borrowed_books, [Types::BookType], null: false

    def borrowed_books
      Book.joins(:user_books).where("user_books.borrower_id = #{object.id}").select("books.*, user_books.id")
    end
  end
end
