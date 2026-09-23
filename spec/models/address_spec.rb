require 'rails_helper'

RSpec.describe Address, type: :model do
before do
@address = FactoryBot.build(:address)
end

describe '配送先住所の保存' do
context '保存できる場合' do
it '郵便番号、都道府県、市区町村、番地、電話番号が正しく入力されていれば保存できる' do
expect(@address).to be_valid
end
end

context '保存できない場合' do
  it '郵便番号が空では保存できない' do
    @address.postal_code = ''
    @address.valid?
    expect(@address.errors.full_messages).to include("Postal code can't be blank")
  end

  it '郵便番号が3桁-4桁の形式でなければ保存できない' do
    @address.postal_code = '1234567'
    @address.valid?
    expect(@address.errors.full_messages).to include('Postal code is invalid')
  end

  it '都道府県が空では保存できない' do
    @address.prefecture_id = nil
    @address.valid?
    expect(@address.errors.full_messages).to include("Prefecture can't be blank")
  end

  it '市区町村が空では保存できない' do
    @address.city = ''
    @address.valid?
    expect(@address.errors.full_messages).to include("City can't be blank")
  end

  it '番地が空では保存できない' do
    @address.address = ''
    @address.valid?
    expect(@address.errors.full_messages).to include("Address can't be blank")
  end

  it '建物名が空でも保存できる' do
    @address.building_name = ''
    expect(@address).to be_valid
  end

  it '電話番号が空では保存できない' do
    @address.phone_number = ''
    @address.valid?
    expect(@address.errors.full_messages).to include("Phone number can't be blank")
  end

  it '電話番号が10桁未満では保存できない' do
    @address.phone_number = '123456789'
    @address.valid?
    expect(@address.errors.full_messages).to include('Phone number is invalid')
  end

  it '電話番号が11桁を超えると保存できない' do
    @address.phone_number = '123456789012'
    @address.valid?
    expect(@address.errors.full_messages).to include('Phone number is invalid')
  end

  it '電話番号にハイフンが含まれていると保存できない' do
    @address.phone_number = '090-1234-5678'
    @address.valid?
    expect(@address.errors.full_messages).to include('Phone number is invalid')
  end
end

end
end
