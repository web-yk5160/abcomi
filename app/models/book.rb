class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :book_likes, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 32 }
  validates :price, presence: true, numericality: true
  validates :author, presence: true
  validates :category, presence: true
  validates :content, presence: true
  validates :published_at, presence: true
  validates :published_by, presence: true
  mount_uploader :image, ImageUploader
  has_one_attached :image

  def book_like(user)
    book_likes.create(user_id: user.id)
  end

  def book_unlike(user)
    book_likes.find_by(user_id: user.id).destroy
  end
end
