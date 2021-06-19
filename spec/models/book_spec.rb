require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:book) { FactoryBot.create(:book) }
    it "nameがなければ無効な状態であること" do
      book.name = nil
      expect(book).to be_invalid
    end

    it "nameが32文字以内であること" do
      book.name = "あ" * 32
      expect(book).to be_valid
    end

    it "user_idがなければ無効な状態であること" do
      book.user_id = nil
      expect(book).to be_invalid
    end
end
