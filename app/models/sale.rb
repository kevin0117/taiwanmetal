class Sale < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :user

  has_many :manifests, dependent: :destroy
  has_many :products, through: :manifests
  validates :sale_date, :gold_selling, :gold_buying, :total_price, presence: true

  enum payment_method: { cash: 0, credit_card: 1, line_pay: 2 }
  paginates_per 10

  def total_weight
    manifests.reduce(0){|sum, m| sum + m.weight}
  end

  def total_service_fee
    manifests.reduce(0){|sum, m| sum + m.service_fee}
  end

  def total_service_profit
    manifests.reduce(0){|sum, m| sum + m.service_profit}
  end
end