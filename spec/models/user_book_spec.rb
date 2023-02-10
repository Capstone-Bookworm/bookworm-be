require 'rails_helper'

RSpec.describe UserBook do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :book}
  end

  describe 'instance methods' do 
    describe '#delete_ownerless_book' do 
      it 'deletes the associated book after a user_book is destroyed, if that user_book was its last association' do 
        book = create(:book)
        user = create(:user)
        userbook = UserBook.create(user: user, book: book)

        expect(Book.all.length).to eq(1)
        
        userbook.destroy

        expect(Book.all.length).to eq(0)
      end
    end
  end
end