class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books

  validates_presence_of :isbn
  validates_uniqueness_of :isbn
  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :summary
  validates_presence_of :page_count
  validates_presence_of :image_url
end
