class Manifest < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  def weight
    product.weight * quantity
  end

  def service_fee
    product.service_fee * quantity
  end

  def cost
    product.cost * quantity
  end

  def service_profit
    service_fee - cost
  end
end
