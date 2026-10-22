class OrderAddress
  include ActiveModel::Model

  attr_accessor :token, :user_id, :item_id,
                :postal_code, :prefecture_id, :city,
                :address, :building_name, :phone_number

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :city
    validates :address
    validates :phone_number
  end

  validates :postal_code,
            format: {
              with: /\A\d{3}-\d{4}\z/,
              message: "is invalid. Enter it as follows (e.g. 123-4567)"
            }

  validates :prefecture_id,
            numericality: {
              other_than: 1,
              message: "can't be blank"
            }

  validates :phone_number, length: { in: 10..11 }

  validates :phone_number,
            format: {
              with: /\A\d+\z/,
              message: "is invalid. Input only number"
            }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(
        user_id: user_id,
        item_id: item_id
      )

      Address.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number,
        order: order
      )
    end

    true
  end
end