class RefineList < ApplicationRecord
  belongs_to :scrap
  belongs_to :refine_order

  def weight
    scrap.gross_weight * quantity
  end

  def service_fee
    scrap.refine_charge * weight * quantity
  end

end