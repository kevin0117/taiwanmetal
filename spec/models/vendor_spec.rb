require 'rails_helper'

RSpec.describe Vendor, type: :model do
  context '當廠商建立成功時..' do
    it '全部欄位正確填寫完成' do
      vendor = FactoryBot.build(:vendor)
      expect(vendor).to be_valid
    end
    it '名稱欄位有填寫' do
      vendor = FactoryBot.build(:vendor, name: "路人甲")
      expect(vendor).to be_valid
    end 
    it '名稱不能是空白' do
      vendor = FactoryBot.build(:vendor, name:'')
      expect(vendor).not_to be_valid
      expect{ expect(vendor).to be_valid }.to raise_exception(/Name can't be blank/)
    end
  end
end
