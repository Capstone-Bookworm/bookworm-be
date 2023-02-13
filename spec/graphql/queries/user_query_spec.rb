require 'rails_helper'

RSpec.describe Types::QueryType do 
  describe 'user' do 
    it 'can get a single user with all of its book info' do 
      user_object = create(:user)
      
      result = BookwormBeSchema.execute(query(user_object.id)).as_json
      user = result["data"]["user"]

      expect(user).to have_key("id")
      expect(user["id"]).to eq(String(user_object.id))

      expect(user).to have_key("userName")
      expect(user["userName"]).to be_a(String)

      expect(user).to have_key("emailAddress")
      expect(user["emailAddress"]).to be_a(String)

      expect(user).to have_key("location")
      expect(user["location"]).to be_a(String)

      expect(user).to have_key("availableBooks")
      expect(user["availableBooks"]).to be_an(Array)

      expect(user).to have_key("pendingRequested")
      expect(user["pendingRequested"]).to be_an(Array)

      expect(user).to have_key("unavailableBooks")
      expect(user["unavailableBooks"]).to be_an(Array)

      expect(user).to have_key("borrowedBooks")
      expect(user["borrowedBooks"]).to be_an(Array)
    end

    describe 'borrowed_books' do 
      it 'only returns books that have been approved to be borrowed' do 
        user = create(:user)
        book_owner = create(:user)
        borrowed_book = create(:book)
        pending_borrowed_book = create(:book)
        UserBook.create(user: book_owner, book: borrowed_book, status: 2, borrower_id: user.id)
        UserBook.create(user: book_owner, book: pending_borrowed_book, status: 1, borrower_id: user.id)

        result = BookwormBeSchema.execute(query(user.id)).as_json
        user_info = result["data"]["user"]

        expect(user_info["borrowedBooks"].length).to eq(1)
        expect(user_info["borrowedBooks"][0]["id"]).to eq(borrowed_book.id.to_s)
      end
    end
  end

  def query(id)
    <<~GQL
      {
        user(id:#{id}) {
            id,
            userName,
            emailAddress,
            location,
            availableBooks {
                id,
                title,
                author,
                imageUrl
            },
            pendingRequested {
                id,
                title,
                imageUrl,
                borrower {
                    id,
                    userName,
                    location,
                    emailAddress    
                }
            },
            unavailableBooks {
                id,
                title,
                imageUrl,
                borrower {
                    id,
                    userName,
                    location,
                    emailAddress    
                }
            }
            borrowedBooks {
                id,
                title,
                author,
                imageUrl
            }
        }
      }
    GQL
  end
end