require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do 
      describe '.resolve' do 
        it 'creates a user' do 
          expect(User.count).to eq(0)

          post "/graphql", params: { query: happy_query }

          expect(User.count).to eq(1)
        end

        it 'returns a User' do 
          post "/graphql", params: { query: happy_query }
          json = JSON.parse(response.body, symbolize_names: true )
          data = json[:data]
          user = data[:createUser][:user]
          
          expect(user[:userName]).to eq('Amanda')
          expect(user[:emailAddress]).to eq('amr@example.com')
          expect(user[:id].to_i).to_not eq(0)
          expect(user[:location]).to eq('Denver')
        end
      end
    end
  end
end


def happy_query
  <<~GQL
    mutation {
      createUser(
        input: {
          userName: "Amanda"
          emailAddress: "amr@example.com"
          location: "Denver"
        }
      ) {
          user {
          userName
          emailAddress
          id
          location
        }
      }
    }
  GQL
end