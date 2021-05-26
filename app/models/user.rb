class User < ApplicationRecord
  has_one_attached :image
  has_many :books, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :book_likes, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
            foreign_key: "follower_id",
            dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
            foreign_key: "followed_id",
            dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  
  def liked_by?(book_id)
    book_likes.where(book_id: book_id).exists?
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end
end
