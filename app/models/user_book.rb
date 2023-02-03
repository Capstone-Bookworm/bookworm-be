class UserBook < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum status: %i[available pending_requested pending_returned unavailable]
end
