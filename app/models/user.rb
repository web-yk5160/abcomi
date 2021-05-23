class User < ApplicationRecord
  has_one_attached :image
  has_many :books, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
end
