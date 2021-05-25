class User < ApplicationRecord
  has_one_attached :image
  has_many :books, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :book_likes, dependent: :destroy
  
  def liked_by?(book_id)
    book_likes.where(book_id: book_id).exists?
  end
end
