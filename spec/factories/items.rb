FactoryBot.define do
  factory :item do
    association :user

    name { 'テスト商品' }
    description { 'テスト商品の説明です' }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 1000 }

    after(:build) do |item|
      item.image.attach(
        io: Rails.root.join('app/assets/images/item-sample.png').open,
        filename: 'item-sample.png',
        content_type: 'image/png'
      )
    end
  end
end
