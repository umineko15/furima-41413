class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user

  has_one_attached :image
  validates :image, presence: true

  validates :name, presence: true

  validates :description, presence: true

  validates :category_id, presence: true

  validates :condition_id, presence: true

  validates :shipping_fee_id, presence: true

  validates :prefecture_id, presence: true
  
  validates :scheduled_delivery_id, presence: true

  validates :price,
            presence: true,
            numericality: {
             only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            }

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :category_id,
          numericality: {
            other_than: 1,
            message: "can't be blank"
          }
          
  validates :condition_id,
          numericality: {
            other_than: 1,
            message: "can't be blank"
          }

  validates :shipping_fee_id,
          numericality: {
            other_than: 1,
            message: "can't be blank"
          }

  validates :prefecture_id,
          numericality: {
            other_than: 1,
            message: "can't be blank"
          }

  validates :scheduled_delivery_id,
          numericality: {
            other_than: 1,
            message: "can't be blank"
          }
end
