class CartItem
  attr_reader :product_id, :quantity

  def initialize(product_id, quantity=1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment(digit=1)
    @quantity += digit
  end

  def decrement(digit=1)
    @quantity -= digit
  end

  def product
    Product.find(product_id)
  end

  def total_price
    (product.price_board.gold_selling * product.weight + product.service_fee) * quantity
  end

  def weight
    product.weight * quantity
  end

  def service_fee
    product.service_fee * quantity
  end
end