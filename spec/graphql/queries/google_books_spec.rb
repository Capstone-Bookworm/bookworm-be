require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'query googleBooks' do
    it 'can query books by title' do
      query = <<~GQL
        query {
          googleBooks(title: "The Moon is a Harsh Mistress") {
            isbn
            title
            author
            imageUrl
            pageCount
            summary
          }
        }
      GQL
      
      VCR.use_cassette('tmiahm') do
        result = BookwormBeSchema.execute(query).first.to_json

        result_hash = JSON.parse(result, symbolize_names: true)
        
        expect(result_hash[1][:googleBooks][0][:isbn]).to be_a String
        expect(result_hash[1][:googleBooks][0][:title]).to be_a String
        expect(result_hash[1][:googleBooks][0][:author]).to be_a String
        expect(result_hash[1][:googleBooks][0][:imageUrl]).to be_a String
        expect(result_hash[1][:googleBooks][0][:pageCount]).to be_a Integer
        expect(result_hash[1][:googleBooks][0][:summary]).to be_a String
      end
    end

    it 'can handle an empty string query' do 
      
      query = <<~GQL
        query {
          googleBooks(title: "") {
            isbn
            title
            author
            imageUrl
            pageCount
            summary
          }
        }
      GQL

      VCR.use_cassette('empty string') do 
        result = BookwormBeSchema.execute(query).first.to_json
        result_hash = JSON.parse(result, symbolize_names: true)

        expect(result_hash[1][:googleBooks]).to eq([])
      end
    end

    it 'can handle a query that does not return results' do 
      query = <<~GQL
        query {
          googleBooks(title: "asdfklsadjfg jaksdlfj sd") {
            isbn
            title
            author
            imageUrl
            pageCount
            summary
          }
        }
      GQL
      VCR.use_cassette('asdfklsadjfg jaksdlfj sd') do
        result = BookwormBeSchema.execute(query).first.to_json
        result_hash = JSON.parse(result, symbolize_names: true)
        expect(result_hash[1][:googleBooks]).to eq([])
      end
    end

    it 'can handle a query with only spaces' do 
      query = <<~GQL
        query {
          googleBooks(title: "   ") {
            isbn
            title
            author
            imageUrl
            pageCount
            summary
          }
        }
      GQL
      VCR.use_cassette('only spaces') do
        result = BookwormBeSchema.execute(query).first.to_json
        result_hash = JSON.parse(result, symbolize_names: true)
        expect(result_hash[1][:googleBooks]).to eq([])
      end
    end
  end
end