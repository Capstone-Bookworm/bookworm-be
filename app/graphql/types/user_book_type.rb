# frozen_string_literal: true

module Types
  class UserBookType < Types::BaseObject
    field :id, ID, null: false
    field :book_id, Integer
    field :user_id, Integer
    field :borrower_id, Integer
    field :status, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
