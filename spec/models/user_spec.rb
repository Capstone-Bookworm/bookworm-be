require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it {should have_many :user_books}
    it {should have_many(:books).through(:user_books)}
  end

  describe 'validations' do 
    it {should validate_presence_of :user_name }
    it {should validate_presence_of :email_address }
    it {should validate_presence_of :location }
    it {should validate_uniqueness_of :email_address }
  end
end