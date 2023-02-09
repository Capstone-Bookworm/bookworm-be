module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :user, Types::UserType, null: false do 
      argument :id, ID, required: true
    end
    
    def user(id:)
      User.find(id)
    end
    
    field :google_books, [Types::GoogleBookType], null: false do 
      argument :title, String, required: true
    end
    
    def google_books(title:)
      BooksFacade.get_book_objects(title)
    end

    field :books, [Types::BookType], null: false

    def books
      Book.take(20)
    end

    field :book_search, [Types::BookType], null: false do
      argument :title, String, required: true
    end

    def book_search(title:)
      Book.where("title ILIKE ?", "%#{title}%").limit(20)
    end

    field :book, Types::BookType, null: false do 
      argument :id, ID, required: true
    end

    def book(id:)
      Book.find(id)
    end

    field :user_login, Types::UserType, null: false do 
      argument :email_address, String, required: true 
    end

    def user_login(email_address:) 
      user = User.find_by(email_address: email_address)
      
      if user.nil?
        raise GraphQL::ExecutionError, "User not found"
      else
        user
      end
    end
  end
end
