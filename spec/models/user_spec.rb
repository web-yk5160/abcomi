require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '正常に登録できること' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
      user.save
    end

    context 'username' do
      subject(:user) { FactoryBot.build(:user) }
      it '空白でないこと' do
        user.username = ''
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("を入力してください")
        expect(user.save).to be_falsey
      end
      it '12文字以内であること' do
        user.username = 'a' * 12
        expect(user).to be_valid
        user.save
      end
      it '13文字以上だと登録できないこと' do
        user.username = 'a' * 13
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("は12文字以内で入力してください")
        expect(user.save).to be_falsey
      end
      it 'usernameが重複していても登録できること' do
        FactoryBot.create(:user, username: 'taken')
        user.username = 'taken'
        expect(user).to be_valid
        user.save
      end
    end

    context 'email' do
      subject(:user) { FactoryBot.build(:user) }
      it '空白でないこと' do
        user.email = ''
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("を入力してください")
        expect(user.save).to be_falsey
      end
      it '重複して登録できないこと' do
        FactoryBot.create(:user, email: 'test@example.com')
        user.email = 'test@example.com'
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("はすでに存在します")
        expect(user.save).to be_falsey
      end
    end

    context 'image' do
      subject(:user) { FactoryBot.build(:user) }
      it 'nilでも登録できること' do
        user.image = nil
        expect(user).to be_valid
        user.save
      end
    end

    context 'password' do
      subject(:user) { FactoryBot.build(:user) }
      it '空白だと登録できないこと' do
        user.password = ''
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("を入力してください")
        expect(user.save).to be_falsey
      end
      it 'passwordが存在しても、password_confirmationが空白だと登録できないこと' do
        user.password_confirmation = ''
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
        expect(user.save).to be_falsey
      end
      it 'passwordとpassword_confirmationが一致していないと登録できないこと' do
        user.password = 'password_A'
        user.password_confirmation = 'password_B'
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
        expect(user.save).to be_falsey
      end
      it '5文字以下だと登録できないこと' do
        user.password = 'a' * 5
        user.password_confirmation = 'a' * 5
        expect(user).to be_invalid
        expect(user.save).to be_falsey
      end
      it '6文字なら登録できること' do
        user.password = 'a' * 6
        user.password_confirmation = 'a' * 6
        expect(user).to be_valid
        user.save
      end
    end
  end

  describe 'アソシエーション' do
    context 'モデルとの関係' do
      it 'Book' do
        expect(User.reflect_on_association(:books).macro).to eq :has_many
      end
    end
  end
end
