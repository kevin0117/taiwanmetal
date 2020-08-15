class RefineItem
  attr_reader :scrap_id, :quantity

  def initialize(scrap_id, quantity=1)
    @scrap_id = scrap_id
    @quantity = quantity
  end

  def increment(digit=1)
    @quantity += digit
  end

  def decrement(digit=1)
    @quantity -= digit
  end

  def scrap
    Scrap.find(scrap_id)
  end

  def weight
    scrap.gross_weight * quantity
  end

  def service_fee
    scrap.refine_charge * scrap.gross_weight * quantity
  end
end