module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :patch_user_book, mutation: Mutations::UserBooks::PatchUserBook
    field :create_book, mutation: Mutations::Books::CreateBook
    field :delete_book, mutation: Mutations::Books::DeleteBook
  end
end
