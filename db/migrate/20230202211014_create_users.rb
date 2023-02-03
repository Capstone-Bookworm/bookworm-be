class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :location
      t.string :email_address

      t.timestamps
    end
  end
end
