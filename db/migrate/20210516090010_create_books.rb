class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.string :author
      t.string :category
      t.text :content
      t.datetime :published_at
      t.string :published_by
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
