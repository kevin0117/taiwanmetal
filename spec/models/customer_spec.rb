require 'rails_helper'

RSpec.describe Customer, type: :model, customer: true do
  context '當客戶建立成功時..' do
    it '全部欄位正確填寫完成' do
      customer = FactoryBot.build(:customer)
      expect(customer).to be_valid
    end
    it '名稱欄位有填寫' do
      customer = FactoryBot.build(:customer, name: "路人甲")
      expect(customer).to be_valid
    end
    it '名稱不能是空白' do
      customer = FactoryBot.build(:customer, name:'')
      expect(customer).not_to be_valid
      expect{ expect(customer).to be_valid }.to raise_exception(/Name 不能為空白/)
    end
    it '可以拿出個別使用者的『營運中』客戶群' do
      kevin = FactoryBot.create(:user, first_name: 'Kevin', last_name: 'Wang', password: '123456')

      customer1 = FactoryBot.create(:customer, online: true, user_id: kevin.id)
      customer2 = FactoryBot.create(:customer, online: true, user_id: kevin.id)
      customer3 = FactoryBot.create(:customer, online: false, user_id: kevin.id)

      expect(Customer.all.available(kevin.id)).to be_include(customer1)
      expect(Customer.all.available(kevin.id)).to be_include(customer2)
      expect(Customer.all.available(kevin.id)).not_to be_include(customer3)
    end
  end
end
