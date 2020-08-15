class RefineCart
  attr_reader :items

  def initialize(items = [])
    @items = items  
  end
 
  def add_scrap(scrap)
    current_item = items.find{|item| item.scrap_id == scrap.id}
    
    if current_item
      current_item.increment
    else
      @items << RefineItem.new(scrap.id)
    end
  end

  def remove_scrap(scrap)
    current_item = items.find{|item| item.scrap_id == scrap.id}
    
    if current_item.quantity > 0
      current_item.decrement
    end
  end

  def destroy_scrap(scrap)
    current_item = items.find{|item| item.scrap_id == scrap.id}

    if current_item
      @items.delete(current_item)
    end
  end

  def empty?
    @items.empty?
  end

  def total_weight
    items.reduce(0) { |sum, item| sum + item.weight }
  end

  def total_service_fee
    items.reduce(0) { |sum, item| sum + item.service_fee }
  end

  def serialize
    all_items = @items.map {|item|
      { "scrap_id" => item.scrap_id, "quantity" => item.quantity }
    }

    { "items" => all_items } 
  end
  
  def self.restore_hash(hash)
    if hash && hash["items"]
      items = hash["items"].map { |item| 
        RefineItem.new(item["scrap_id"], item["quantity"]) 
      }
      RefineCart.new(items)
    else
      RefineCart.new
    end
  end

  def scrap_list
    id_list = @items.map { |item| Scrap.find(item.scrap_id) }  
  end
end