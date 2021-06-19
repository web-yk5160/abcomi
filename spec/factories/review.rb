FactoryBot.define do
    factory :review do
      title { 'review_title' }
      content { 'review_content' }
      association :user
      association :book
    end
  end
