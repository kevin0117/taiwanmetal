class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_product(product)
    current_item = items.find{|item| item.product_id == product.id}

    if current_item
      current_item.increment
    else
      @items << CartItem.new(product.id)
    end
  end

  def remove_product(product)
    current_item = items.find{|item| item.product_id == product.id}

    if current_item.quantity > 0
      current_item.decrement
    end
  end

  def destroy_product(product)
    current_item = items.find{|item| item.product_id == product.id}

    if current_item
      @items.delete(current_item)
    end
  end

  def empty?
    @items.empty?
  end

  def total_price(gold_selling)
    @items.reduce(0) {|sum, item| sum + item.price(gold_selling) }
  end

  def total_weight
    items.reduce(0) { |sum, item| sum + item.weight }
  end

  def total_cost
    items.reduce(0) { |sum, item| sum + item.cost }
  end

  def total_service_fee
    items.reduce(0) { |sum, item| sum + item.service_fee }
  end

  def total_service_profit
    total_service_fee - total_cost
  end

  def serialize
    all_items = @items.map {|item|
      { "product_id" => item.product_id, "quantity" => item.quantity }
    }

    { "items" => all_items } 
  end
  
  def self.restore_hash(hash)
    if hash && hash["items"]
      items = hash["items"].map { |item| 
        CartItem.new(item["product_id"], item["quantity"]) 
      }
      Cart.new(items)
    else
      Cart.new
    end
  end
end