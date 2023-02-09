require 'rails_helper'

RSpec.describe Types::QueryType do 
  describe 'user_login' do 
    it 'can receive an email address and return the user' do 
      user_object = create(:user)

      result = BookwormBeSchema.execute(query(user_object.email_address)).as_json
      user = result["data"]["userLogin"]

      expect(user["id"].to_i).to eq(user_object.id)
      expect(user["userName"]).to eq(user_object.user_name)
      expect(user["emailAddress"]).to eq(user_object.email_address)
      expect(user["location"]).to eq(user_object.location)
    end

    it 'returns an error if there is no matching email address' do 
      user_object = create(:user)

      result = BookwormBeSchema.execute(query("notanemail@example.com")).as_json
      
      expect(result["data"]).to eq(nil)
      expect(result["errors"][0]["message"]).to eq("User not found")
    end
  end

  def query(email)
    <<~GQL
      {
        userLogin(emailAddress: "#{email}") {
            id,
            userName,
            emailAddress,
            location
          }
      }
    GQL
  end
end