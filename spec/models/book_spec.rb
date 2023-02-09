require 'rails_helper'

RSpec.describe Book do
  describe 'relationships' do
    it {should have_many :user_books}
    it {should have_many(:users).through(:user_books)}
  end

  describe 'validations' do
    it {should validate_presence_of :isbn}
    it {should validate_presence_of :title}
    it {should validate_presence_of :author}
    it {should validate_presence_of :image_url}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :summary}
    it {should validate_uniqueness_of :isbn}
  end
end