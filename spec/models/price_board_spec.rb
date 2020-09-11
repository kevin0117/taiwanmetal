require 'rails_helper'

RSpec.describe PriceBoard, type: :model, price: true do
  let(:user1) { User.create(first_name: "Kevin", last_name: "Wang", email: "kevin111@gmail.com", password: "123456") }
  let(:user2) { User.create(first_name: "Annie", last_name: "Wang", email: "Annie111@gmail.com", password: "123456") }
  
  context '當每日貴金屬價格成功建立時..' do
    it '全部欄位正確輸入完成' do
      pb = FactoryBot.build(:price_board)
      expect(pb).to be_valid
    end
    it '黃金價格(盤商賣出)有填寫'do
      pb = FactoryBot.build(:price_board, wholesale_gold_selling: 6000)
      expect(pb).to be_valid
    end
    it '黃金價格(盤商賣出)沒有填寫'do
      pb = FactoryBot.build(:price_board, wholesale_gold_selling: "")
      expect(pb).not_to be_valid
      expect{ expect(pb).to be_valid }.to raise_exception(/Wholesale gold selling 不能為空白/)
    end
    it '黃金價格(盤商買進)有填寫'do
      pb = FactoryBot.build(:price_board, wholesale_gold_buying: 6000)
      expect(pb).to be_valid
    end
    it '黃金價格(盤商買進)沒有填寫'do
      pb = FactoryBot.build(:price_board, wholesale_gold_buying: "")
      expect(pb).not_to be_valid
      expect{ expect(pb).to be_valid }.to raise_exception(/Wholesale gold buying 不能為空白/)
    end
    it '黃金價格(賣出)有填寫'do
      pb = FactoryBot.build(:price_board, gold_selling: 6000)
      expect(pb).to be_valid
    end
    it '黃金價格(賣出)沒有填寫'do
      pb = FactoryBot.build(:price_board, gold_selling: "")
      expect(pb).not_to be_valid
      expect{ expect(pb).to be_valid }.to raise_exception(/Gold selling 不能為空白/)
    end
    it '黃金價格(買進)有填寫'do
      pb = FactoryBot.build(:price_board, gold_buying: 6000)
      expect(pb).to be_valid
    end
    it '黃金價格(買進)沒有填寫'do
      pb = FactoryBot.build(:price_board, gold_buying: "")
      expect(pb).not_to be_valid
      expect{ expect(pb).to be_valid }.to raise_exception(/Gold buying 不能為空白/)
    end
    it '黃金價格(賣出)可依照當天日期及個別使用者來預設填寫' do
      pb1 = FactoryBot.create(:price_board, price_date: "2020-09-11", 
                              user_id: user1.id, gold_selling: 6000)    

      pb2 = FactoryBot.create(:price_board, price_date: "2020-09-11", 
                              user_id: user2.id, gold_selling: 5000)    

      pb3 = FactoryBot.create(:price_board, price_date: "2020-09-12", 
                              user_id: user1.id, gold_selling: 4000)   

      expect(PriceBoard.find_gold_selling(user1.id, "2020-09-11") == 6000).to be_truthy
      expect(PriceBoard.find_gold_selling(user1.id, "2020-09-12") == 4000).to be_truthy
      expect(PriceBoard.find_gold_selling(user2.id, "2020-09-11") == 6000).to be_falsy
    end
    it '黃金價格(買進)可依照當天日期及個別使用者來預設填寫' do
      pb1 = FactoryBot.create(:price_board, price_date: "2020-09-11", 
                              user_id: user1.id, gold_buying: 6000)

      pb2 = FactoryBot.create(:price_board, price_date: "2020-09-11", 
                              user_id: user2.id, gold_buying: 5000)    

      pb3 = FactoryBot.create(:price_board, price_date: "2020-09-12", 
                              user_id: user1.id, gold_buying: 4000)   

      expect(PriceBoard.find_gold_buying(user1.id, "2020-09-11") == 6000).to be_truthy
      expect(PriceBoard.find_gold_buying(user1.id, "2020-09-12") == 4000).to be_truthy
      expect(PriceBoard.find_gold_buying(user2.id, "2020-09-11") == 6000).to be_falsy
    end

    it '如果『每日金價未建立』或是『使用者不存在』, 黃金價格(賣出)將預設為 0' do
      # 建立ㄧ筆貴金屬價格測試假資料
      default = PriceBoard.create( 
        wholesale_gold_selling: 0, wholesale_gold_buying: 0,
        gold_selling: 0, gold_buying: 0, 
        price_date: "2020-01-01", user_id: user1.id)   
      pb1 = FactoryBot.create(
        :price_board, price_date: "2020-09-12", 
        user_id: user1.id, gold_selling: 6000)
      
      expect(PriceBoard.find_gold_selling(user1.id, "2020-09-12") == 6000).to be_truthy
      expect(PriceBoard.find_gold_selling(user1.id) == 0.0).to be_truthy
      expect(PriceBoard.find_gold_selling(user2.id, "2020-09-12") == 0.0).to be_truthy
    end
    it '如果『每日金價未建立』或是『使用者不存在』, 黃金價格(買進)將預設為 0' do
      # 資料庫內建第一筆所有貴金屬價格資料為零
      default = PriceBoard.create( 
        wholesale_gold_selling: 0, wholesale_gold_buying: 0,
        gold_selling: 0, gold_buying: 0, 
        price_date: "2020-01-01", user_id: user1.id)   
      # 建立ㄧ筆貴金屬價格測試假資料
      pb1 = FactoryBot.create(
        :price_board, price_date: "2020-09-12", 
        user_id: user1.id, gold_buying: 6000)

      expect(PriceBoard.find_gold_buying(user1.id, "2020-09-12") == 6000).to be_truthy
      expect(PriceBoard.find_gold_buying(user1.id) == 0.0).to be_truthy
      expect(PriceBoard.find_gold_buying(user2.id, "2020-09-12") == 0.0).to be_truthy
    end
  end
end
