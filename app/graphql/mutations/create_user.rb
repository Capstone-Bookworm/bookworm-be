class Mutations::CreateUser < Mutations::BaseMutation 
  argument :email_address, String, required: true
  argument :user_name, String, required: true 
  argument :location, String, required: true
  
  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(email_address:, user_name:, location:)
    user = User.new(email_address: email_address, user_name: user_name, location: location)
    if user.save
      {
        user: user,
        errors: []
      }
    else 
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end