class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :nickname, presence: true

  validates :email, format: { with: /\A.+@.+\z/ }

  validates :password,
    format: {
      with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
      message: 'is invalid'
    }

  validates_confirmation_of :password

  validates :last_name,  presence: true

  validates :first_name, presence: true

  validates :last_name,
    format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }

  validates :first_name,
  format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }

  validates :last_name_kana, presence: true

  validates :first_name_kana, presence: true

  validates :last_name_kana,
    format: { with: /\A[ァ-ヶー]+\z/ }

  validates :first_name_kana,
  format: { with: /\A[ァ-ヶー]+\z/ }

  validates :birthday, presence: true
end
