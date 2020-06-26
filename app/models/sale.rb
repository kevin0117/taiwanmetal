class Sale < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :user

  has_many :manifests, dependent: :destroy
  has_many :products, through: :manifests

  enum payment_method: { cash: 0, credit_card: 1, line_pay: 2 }

end
