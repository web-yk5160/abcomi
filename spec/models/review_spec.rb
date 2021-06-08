require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:review) { FactoryBot.create(:review) }
  it "titleが存在しない場合登録できないこと" do
    review.title = ""
    expect(review).to be_invalid
  end

  it "contentが存在しない場合登録できないこと" do
    review.content = ""
    expect(review).to be_invalid
  end

  it "contentが140文字の場合登録できること" do
    review.content = "あ" * 140
    expect(review).to be_valid
  end

  it "contentが141文字の場合登録できないこと" do
    review.content = "あ" * 141
    expect(review).to be_invalid
  end

  it "user_idとbook_idが存在しないと登録できないこと" do
    review.book_id = ""
    review.user_id = ""
    expect(review).to be_invalid
  end
end
