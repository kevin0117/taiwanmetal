class Manifest < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  def weight
    product.weight * quantity
  end

  def service_fee
    product.service_fee * quantity
  end

end
