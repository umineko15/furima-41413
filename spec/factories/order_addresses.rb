FactoryBot.define do
  factory :order_address do
    token { "tok_abcdefghijk00000000000000000" }
    user_id { 1 }
    item_id { 1 }
    postal_code { "123-4567" }
    prefecture_id { 2 }
    city { "大阪市" }
    address { "1-2-3" }
    building_name { "マツダビル" }
    phone_number { "09012345678" }
  end
end