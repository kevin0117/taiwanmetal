class PriceBoard < ApplicationRecord
  belongs_to :user

  def self.find_gold_selling(id, date = Date.today)
    date = date.to_s.split(' ').first

    target_date = PriceBoard.select{ |item| 
      item.price_date.to_s == date && item.user_id == id
    }  
    if target_date.empty?
      PriceBoard.last.gold_selling if PriceBoard.last.present?
    else
      target_date.first.gold_selling
    end
  end



  def self.find_gold_buying(id, date = Date.today)
    date = date.to_s.split(' ').first

    target_date = PriceBoard.select{ |item| 
      item.price_date.to_s == date && item.user_id == id
    }  
    if target_date.empty?
      PriceBoard.last.gold_buying if PriceBoard.last.present?
    else
      target_date.first.gold_buying
    end
  end
  
end
