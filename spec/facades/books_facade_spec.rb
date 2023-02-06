require 'rails_helper'

RSpec.describe BooksFacade do
  describe 'class methods' do
    describe '#get_book_objects' do
      it 'returns an array of BookPoro objects' do
        VCR.use_cassette('google_books_tmiahm') do
          books = BooksFacade.get_book_objects('The Moon is a Harsh Mistress', 'Heinlein')

          books.each do |book|
            expect(book).to be_a BookPoro
          end
        end
      end
    end
  end
end