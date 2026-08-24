require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.build(:item) }
  
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(item).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'imageが空では出品できない' do
        item.image = ''
        item.valid?
        expect(item.errors.full_messages).to include "Image can't be blank"
      end
      it 'nameが空では出品できない' do
        item.name = ''
        item.valid?
        expect(item.errors.full_messages).to include "Name can't be blank"
      end
      it 'descriptionが空では出品できない' do
        item.description = ''
        item.valid?
        expect(item.errors.full_messages).to include "Description can't be blank"
      end
      it 'category_idが空では出品できない' do
        item.category_id = ''
        item.valid?
        expect(item.errors.full_messages).to include "category_id can't be blank"
      end
      it 'condition_idが空では出品できない' do
        item.condition_id = ''
        item.valid?
        expect(item.errors.full_messages).to include "condition_id can't be blank"
      end
      it 'shipping_fee_idが空では出品できない' do
        item.shipping_fee_id = ''
        item.valid?
        expect(item.errors.full_messages).to include "shipping_fee_id can't be blank"
      end
      it 'prefecture_idが空では出品できない' do
        item.prefecture_id = ''
        item.valid?
        expect(item.errors.full_messages).to include "prefecture_id can't be blank"
      end
      it 'scheduled_delivery_idが空では出品できない' do
        item.scheduled_delivery_id = ''
        item.valid?
        expect(item.errors.full_messages).to include "scheduled_delivery_id can't be blank"
      it 'priceが空では出品できない' do
        item.price = ''
        item.valid?
        expect(item.errors.full_messages).to include "price can't be blank"
      end
      it '価格が300円未満では出品できない' do
        item.price = 299
        item.valid?
        expect(item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格が10,000,000円以上では出品できない' do
        item.price = 10_000_000
        item.valid?
        expect(item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格が全角数字では出品できない' do
        item.price = '３００'
        item.valid?
        expect(item.errors[:price]).to be_present
      end
      it '価格が英字を含むと出品できない' do
        item.price = '300abc'
        item.valid?
        expect(item.errors[:price]).to be_present
      end
    end
  end
end
