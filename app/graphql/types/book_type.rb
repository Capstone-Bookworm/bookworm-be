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
  end
end
