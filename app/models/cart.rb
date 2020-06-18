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
    
    if current_item
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

  def total_price
    @items.reduce(0) {|sum, item| sum + item.total_price }
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