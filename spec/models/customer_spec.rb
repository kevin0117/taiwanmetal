require 'rails_helper'

RSpec.describe Customer, type: :model do
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
      expect{ expect(customer).to be_valid }.to raise_exception(/Name can't be blank/)
    end
  end
end
