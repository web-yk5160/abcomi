class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  has_one_attached :image
  has_many :books, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { maximum: 12 }
  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
  has_many :reviews, dependent: :destroy
  has_many :book_likes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :study_abroad_expectations, dependent: :destroy
  accepts_nested_attributes_for :study_abroad_expectations
  has_many :study_abroad_targets, dependent: :destroy
  accepts_nested_attributes_for :study_abroad_targets

  def liked_by?(book_id)
    book_likes.exists?(book_id: book_id)
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

  def self.guest 
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
