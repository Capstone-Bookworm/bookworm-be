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
      borrower_id = UserBook.where(user_id: object.user_id).where(book_id: object.id).first.borrower_id
      User.find(borrower_id)
    end

    field :users, [Types::UserType], null: false

    def users
      # ForeignKeyLoader.for(User).load_all
    end
  end
end
