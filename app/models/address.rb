class Address < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/ }

  validates :prefecture_id, presence: true

  validates :city, presence: true

  validates :address, presence: true

  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
end
