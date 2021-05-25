class CreateBookLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :book_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :book_id], unique: true
    end
  end
end
