require 'rails_helper'

RSpec.describe GoogleBooksService do
  describe 'class methods' do
    describe '#search' do
      it 'returns JSON with search results of the query' do
        VCR.use_cassette('google_books_tmiahm') do
          books = GoogleBooksService.search('The Moon is a Harsh Mistress')
  
          expect(books[:items]).to be_a Array
          expect(books[:items][0][:volumeInfo][:title]).to be_a String
          expect(books[:items][0][:volumeInfo][:authors][0]).to be_a String
          expect(books[:items][0][:volumeInfo][:description]).to be_a String
          expect(books[:items][0][:volumeInfo][:industryIdentifiers][0][:identifier]).to be_a String
          expect(books[:items][0][:volumeInfo][:pageCount]).to be_a Integer
          expect(books[:items][0][:volumeInfo][:imageLinks][:thumbnail]).to be_a String
        end
      end
    end
  end
end