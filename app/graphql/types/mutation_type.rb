module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :patch_user_book, mutation: Mutations::UserBooks::PatchUserBook
  end
end
