module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :user, Types::UserType, null: false do 
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    field :books, [Types::BookType], null: false

    def books
      Book.take(20)
    end

    field :book_search, [Types::BookType], null: false do
      argument :title, String, required: true
    end

    def book_search(title:)
      Book.where("title LIKE ?", "%#{title}%").limit(20)
    end
  end
end
