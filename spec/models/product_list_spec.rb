require 'rails_helper'

RSpec.describe ProductList, type: :model do
  context '當產品名單建立成功時' do
    it '全部欄位正確填寫完成' do
      pl = FactoryBot.build(:product_list)
      expect(pl).to be_valid
    end
    it '名稱欄位有填寫' do
      pl = FactoryBot.build(:product_list, name: '黃金條塊')
      expect(pl).to be_valid
    end
    it '名稱不能是空白' do
      pl = FactoryBot.build(:product_list, name: '')
      expect(pl).not_to be_valid
      expect{ expect(pl).to be_valid }.to raise_exception(/Name can't be blank/)
    end
  end
end
