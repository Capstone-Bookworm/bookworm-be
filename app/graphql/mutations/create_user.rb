module Mutations
  class CreateUser < BaseMutation 
    argument :email_address, String, required: true
    argument :user_name, String, required: true 
    argument :location, String, required: true

    field :user, Types::UserType, null: false 
    field :errors, [String], null: false

    def resolve(email_address: nil, user_name: nil, location: nil)
      user = User.new(email_address: email_address, user_name: user_name, location: location)

      if user.save
        {
          user: user
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end