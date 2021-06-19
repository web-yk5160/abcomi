require 'rails_helper'

RSpec.describe BookLike, type: :model do
  let!(:book_like) { FactoryBot.create(:book_like) }
    it "book_likeが有効であること" do
      expect(book_like).to be_valid
    end

    it "post_idがなければ無効な状態であること" do
      book_like.book_id = nil
      expect(book_like).to be_invalid
    end

    it "user_idがなければ無効な状態であること" do
      book_like.user_id = nil
      expect(book_like).to be_invalid
    end
end
