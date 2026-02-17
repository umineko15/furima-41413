require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = FactoryBot.build(:user)
      user.nickname = ''
      user.valid?
      expect(user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'emailが空では登録できない' do
      user = FactoryBot.build(:user)
      user.email = ''
      user.valid?
      expect(user.errors.full_messages).to include "Email can't be blank"
    end
    it 'emailが一意でないと登録できない' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.build(:user, email: user1.email)

      user2.valid?
      expect(user2.errors.full_messages).to include "Email has already been taken"
    end
    it 'emailに@が含まれていないと登録できない' do
      user = FactoryBot.build(:user, email: 'testexample.com')
      user.valid?
      expect(user.errors.full_messages).to include 'Email is invalid'
    end
    it 'passwordが空では登録できない' do
      user = FactoryBot.build(:user)
      user.password = ''
      user.valid?
      expect(user.errors.full_messages).to include "Password can't be blank"
    end
    it 'passwordが6文字未満だと登録できない' do
      user = FactoryBot.build(:user)
      user.password = 'a1b2c'          # 5文字
      user.password_confirmation = 'a1b2c'
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordが英字のみでは登録できない' do
      user = FactoryBot.build(:user)
      user.password = 'abcdef'
      user.password_confirmation = 'abcdef'
      user.valid?
      expect(user.errors.full_messages).to include ("Password is invalid")
    end
    it 'passwordが数字のみでは登録できない' do
      user = FactoryBot.build(:user)
      user.password = '123456'
      user.password_confirmation = '123456'
      user.valid?
      expect(user.errors.full_messages).to include "Password is invalid"
    end
    it 'last_nameが空では登録できない' do
      user = FactoryBot.build(:user)
      user.last_name = ''
      user.valid?
      expect(user.errors.full_messages).to include "Last name can't be blank"
    end
    it 'first_nameが空では登録できない' do
      user = FactoryBot.build(:user)
      user.first_name = ''
      user.valid?
      expect(user.errors.full_messages).to include "First name can't be blank"
    end
    it 'last_nameが半角では登録できない' do
      user = FactoryBot.build(:user)
      user.last_name = 'yamada'
      user.valid?
      expect(user.errors.full_messages).to include "Last name is invalid"
    end
    it 'first_nameが半角では登録できない' do
      user = FactoryBot.build(:user)
      user.first_name = 'taro'
      user.valid?
      expect(user.errors.full_messages).to include "First name is invalid"
    end

    it 'last_name_kanaが空では登録できない' do
      user = FactoryBot.build(:user)
      user.last_name_kana = ''
      user.valid?
      expect(user.errors.full_messages).to include "Last name kana can't be blank"
    end
    it 'first_name_kanaが空では登録できない' do
      user = FactoryBot.build(:user)
      user.first_name_kana = ''
      user.valid?
      expect(user.errors.full_messages).to include "First name kana can't be blank"
    end
    it 'last_name_kanaがカタカナ以外では登録できない' do
      user = FactoryBot.build(:user)
      user.last_name_kana = 'yamada'
      user.valid?
      expect(user.errors.full_messages).to include "Last name kana is invalid"
    end
    it 'first_name_kanaがカタカナ以外では登録できない' do
      user = FactoryBot.build(:user)
      user.first_name_kana = 'taro'
      user.valid?
      expect(user.errors.full_messages).to include "First name kana is invalid"
    end
    it 'birthdayが空では登録できない' do
      user = FactoryBot.build(:user)
      user.birthday = ''
      user.valid?
      expect(user.errors.full_messages).to include "Birthday can't be blank"
    end
  end
end
