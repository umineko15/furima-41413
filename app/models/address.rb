class Address < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true
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

  validates :city, presence: true

  validates :address, presence: true

  validates :phone_number, presence: true
  validates :phone_number,
            length: { in: 10..11 }
  validates :phone_number,
            format: {
              with: /\A\d+\z/,
              message: "is invalid. Input only number"
            }
end
