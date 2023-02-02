class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.references :borrower
      t.integer :status

      t.timestamps
    end
    add_foreign_key :user_books, :users, column: :id
  end
end
