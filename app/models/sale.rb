class Sale < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :user

  has_many :manifests, dependent: :destroy
  has_many :products, through: :manifests
  validates :sale_date, :gold_selling, :gold_buying, :total_price, presence: true

  enum payment_method: { cash: 0, credit_card: 1, line_pay: 2 }

end