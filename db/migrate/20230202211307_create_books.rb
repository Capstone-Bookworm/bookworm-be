class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :image_url
      t.integer :page_count
      t.string :summary

      t.timestamps
    end
  end
end
