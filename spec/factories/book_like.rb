FactoryBot.define do
    factory :book_like do
      association :user
      association :book
    end
  end
