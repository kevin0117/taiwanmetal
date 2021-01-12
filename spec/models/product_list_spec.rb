require 'rails_helper'

RSpec.describe ProductList, type: :model, list: true do
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
      expect{ expect(pl).to be_valid }.to raise_exception(/Name 不能為空白/)
    end
    it '可以拿出個別使用者『上架中』的產品名稱' do
      kevin = FactoryBot.create(:user, first_name: 'Kevin', last_name: 'Wang', password: '123456')
      annie = FactoryBot.create(:user, first_name: 'Annie', last_name: 'Wang', password: '123456')

      product_list1 = FactoryBot.create(:product_list, online: true, user_id: kevin.id)
      product_list2 = FactoryBot.create(:product_list, online: true, user_id: kevin.id)
      product_list3 = FactoryBot.create(:product_list, online: false, user_id: kevin.id)
      product_list4 = FactoryBot.create(:product_list, online: true, user_id: kevin.id)

      expect(ProductList.all.available(kevin.id)).to be_include(product_list1)
      expect(ProductList.all.available(kevin.id)).to be_include(product_list2)
      expect(ProductList.all.available(kevin.id)).not_to be_include(product_list3)
    end
  end
end
