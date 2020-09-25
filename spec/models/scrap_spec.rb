require 'rails_helper'

RSpec.describe Scrap, type: :model, scrap: true do
  context '貴金屬回收成功建立時..' do
    it '全部欄位正確填寫' do
      scrap = FactoryBot.create(:scrap)

      expect(scrap).to be_valid
    end

    it '名稱有填寫' do
      scrap = FactoryBot.create(:scrap, title: "舊金項鍊")

      expect(scrap).to be_valid
    end

    it '名稱不能是空白' do
      scrap = FactoryBot.build(:scrap, title: '')

      expect(scrap).not_to be_valid
      expect{ expect(scrap).to be_valid }.to raise_exception(/Title 不能為空白/)
    end

    it '重量有填寫' do
      scrap = FactoryBot.create(:scrap, gross_weight: "2.33")

      expect(scrap).to be_valid
    end

    it '重量不能是空白' do
      scrap = FactoryBot.build(:scrap, gross_weight: '')

      expect(scrap).not_to be_valid
      expect{ expect(scrap).to be_valid }.to raise_exception(/Gross weight 不能為空白/)
    end
    it '成色有填寫' do
      scrap = FactoryBot.create(:scrap, wastage_rate: "0.95")

      expect(scrap).to be_valid
    end

    it '成色不能是空白' do
      scrap = FactoryBot.build(:scrap, wastage_rate: '')

      expect(scrap).not_to be_valid
      expect{ expect(scrap).to be_valid }.to raise_exception(/Wastage rate 不能為空白/)
    end
    it '金價欄位有填寫' do
      scrap = FactoryBot.create(:scrap, gold_buying: "6000")

      expect(scrap).to be_valid
    end

    it '金價不能是空白' do
      scrap = FactoryBot.build(:scrap, gold_buying: '')

      expect(scrap).not_to be_valid
      expect{ expect(scrap).to be_valid }.to raise_exception(/Gold buying 不能為空白/)
    end

    it '可以拿出所有『有庫存』的待提煉舊金' do
      scrap1 = FactoryBot.create(:scrap, in_stock: true)
      scrap2 = FactoryBot.create(:scrap, in_stock: true)
      scrap3 = FactoryBot.create(:scrap, in_stock: false)
      scrap4 = FactoryBot.create(:scrap, in_stock: true)

      expect(Scrap.all.available).to be_include(scrap1)
      expect(Scrap.all.available).to be_include(scrap2)
      expect(Scrap.all.available).not_to be_include(scrap3)
    end
  end
end
