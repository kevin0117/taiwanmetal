class PriceBoard < ApplicationRecord
  belongs_to :user

  # If the date is not passing through, the default value of date will be set to today 
  # it will return for today's price 

  # If the date is passing through with nil value, the price_boards will be empty
  # It will return the latest price in recorded in the database 
  
  # If the date is set and can be found in the database, 
  # it will return the price according to the date

  def self.find_gold_selling(id, date = Date.today)
    date = date.to_s.split(' ').first

    price_boards = PriceBoard.select{ |item| 
      item.price_date.to_s == date && item.user_id == id
    }  
    if price_boards.empty?
      PriceBoard.last.gold_selling if PriceBoard.last.present?
    else
      price_boards.first.gold_selling
    end
  end

  def self.find_gold_buying(id, date = Date.today)
    date = date.to_s.split(' ').first

    price_boards = PriceBoard.select{ |item| 
      item.price_date.to_s == date && item.user_id == id
    }  
    
    if price_boards.empty?
      PriceBoard.last.gold_buying if PriceBoard.last.present?
    else
      price_boards.first.gold_buying
    end
  end
  
end
