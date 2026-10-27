require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '購入情報の入力チェック' do
    context '保存できる場合' do
      it '必要な項目が正しく入力されていれば有効である' do
        expect(@order_address).to be_valid
      end
    end

    context '保存できない場合' do
      it 'tokenが空では登録できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("Token can't be blank")
      end

      it 'ユーザーIDが空では登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("User can't be blank")
      end

      it '商品IDが空では登録できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("Item can't be blank")
      end

      it '郵便番号が空では登録できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("Postal code can't be blank")
      end

      it '郵便番号が3桁-4桁の形式でなければ登録できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県が未選択では登録できない' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("Prefecture can't be blank")
      end

      it '市区町村が空では登録できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("City can't be blank")
      end

      it '番地が空では登録できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("Address can't be blank")
      end

      it '建物名が空でも有効である' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end

      it '電話番号が空では登録できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満では登録できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include('Phone number is too short (minimum is 10 characters)')
      end

      it '電話番号が11桁を超えると登録できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include('Phone number is too long (maximum is 11 characters)')
      end

      it '電話番号にハイフンが含まれていると登録できない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
          .to include('Phone number is invalid. Input only number')
      end
    end
  end
end