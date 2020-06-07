require 'rails_helper'

RSpec.describe Product, type: :model do
  context '當商品成功建立時..' do
    it '全部欄位正確填寫完成' do
      p1 = FactoryBot.create(:product)

      expect(p1).to be_valid
    end
    it '名稱有填寫' do
      p1 = FactoryBot.create(:product, title:'黃金項鍊')

      expect(p1).to be_valid
    end
    it '名稱不能是空白' do
      p1 = FactoryBot.build(:product, title:'')

      expect(p1).not_to be_valid
      expect{ expect(p1).to be_valid }.to raise_exception(/Title can't be blank/)
    end
    it '重量有填寫' do
      p1 = FactoryBot.create(:product, weight: '3.23')
      expect(p1).to be_valid
    end

    it '重量不能是空白' do
      p1 = FactoryBot.build(:product, weight: '')
      expect(p1).not_to be_valid
      expect { expect(p1).to be_valid }.to raise_exception(/Weight can't be blank/)
    end
    it '成本有填寫' do
      p1 = FactoryBot.create(:product, cost: '200')
      expect(p1).to be_valid
    end

    it '成本不能是空白' do
      p1 = FactoryBot.build(:product, cost: '')
      expect(p1).not_to be_valid
      expect { expect(p1).to be_valid }.to raise_exception(/Cost can't be blank/)
    end
    it '工錢有填寫' do
      p1 = FactoryBot.create(:product, service_fee: '200')
      expect(p1).to be_valid
    end

    it '工錢不能是空白' do
      p1 = FactoryBot.build(:product, service_fee: '')
      expect(p1).not_to be_valid
      expect { expect(p1).to be_valid }.to raise_exception(/Service fee can't be blank/)
    end
  end
end
