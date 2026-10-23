require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '購入情報の保存' do
    context '保存できる場合' do
      it 'ユーザーと商品とカード情報が存在すれば保存できる' do
        expect(@order).to be_valid
      end
    end

    context 'tokenのバリデーション' do
      it "tokenがあれば有効であること" do
        @order.token = "tok_abcdefghijk00000000000000000"
        expect(@order).to be_valid
      end

      it "tokenが空では登録できないこと" do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages)
          .to include("Token can't be blank")
      end
    end

    context '保存できない場合' do
      it 'ユーザーが紐づいていなければ保存できない' do
        @order.user = nil
        @order.valid?
        expect(@order.errors.full_messages).to include "User must exist"
      end

      it '商品が紐づいていなければ保存できない' do
        @order.item = nil
        @order.valid?
        expect(@order.errors.full_messages).to include "Item must exist"
      end
    end
  end
end