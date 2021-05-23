class Book < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    validates :user_id, presence: true
    validates :name, presence: true, length: {maximum: 32}
    has_many :reviews, dependent: :destroy
end
