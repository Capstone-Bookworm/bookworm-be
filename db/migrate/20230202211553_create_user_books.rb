class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :borrower_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
