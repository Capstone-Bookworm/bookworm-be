class User < ApplicationRecord
  has_many :user_books
  has_many :books, through: :user_books

  validates_presence_of :user_name
  validates_presence_of :email_address
  validates_presence_of :location
  validates_uniqueness_of :email_address
end
