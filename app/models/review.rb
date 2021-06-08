class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
