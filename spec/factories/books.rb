FactoryBot.define do
    factory :book do
        name { '書籍名' }
        price { '1500' }
        author { '著者' }
        category { 'カテゴリー' }
        content { '書籍内容' }
        published_at { '2021-05-25' }
        published_by { '出版社' }
        # after(:build) do |post|
        # post.image.attach(io: File.open('spec/fixtures/noimage.jpg'), filename: 'noimage.jpg', content_type: 'image/jpg')
        # end
        association :user
    end
end
