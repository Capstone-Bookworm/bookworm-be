class UserBook < ApplicationRecord
  belongs_to :book_id
  belongs_to :user_id
end
