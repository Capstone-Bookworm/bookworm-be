# frozen_string_literal: true

module Types
  class GoogleBookType < Types::BaseObject
    field :isbn, String
    field :title, String
    field :author, String
    field :image_url, String
    field :page_count, Integer
    field :summary, String
  end
end
