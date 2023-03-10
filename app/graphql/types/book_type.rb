# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :isbn, String
    field :title, String
    field :author, String
    field :image_url, String
    field :page_count, Integer
    field :summary, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :borrower, Types::UserType, null: false

    def borrower
      borrower_id = UserBook.find_by(book_id: object.id, user_id: object.user_id).borrower_id
      if borrower_id.nil?
        {}
      else
        User.find(borrower_id)
      end
    end

    field :users, [Types::UserType], null: false

    def users
      User.joins(:user_books)
        .where("user_books.book_id = #{object.id}")
        .where("user_books.status = 0")
    end
  end
end
