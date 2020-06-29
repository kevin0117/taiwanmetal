class PriceBoard < ApplicationRecord

  def self.find_gold_selling(sale_date)
    date = sale_date.to_s.split(' ').first
    target_date = PriceBoard.find_by(price_date: date)
    if target_date
      target_date.gold_selling 
    else
      PriceBoard.last.gold_selling if PriceBoard.last.present?
    end
  end

  def self.find_gold_buying(sale_date)
    date = sale_date.to_s.split(' ').first
    target_date = PriceBoard.find_by(price_date: date)
    if target_date
      target_date.gold_buying
    else
      PriceBoard.last.gold_buying if PriceBoard.last.present?
    end
  end
  
end
