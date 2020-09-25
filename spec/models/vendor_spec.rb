require 'rails_helper'

RSpec.describe Vendor, type: :model, vendor: true do
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
      expect{ expect(vendor).to be_valid }.to raise_exception(/Name 不能為空白/)
    end
    it '可以拿出個別使用者的『營運中』廠商群' do
      kevin = User.create(first_name: "Kevin", last_name: "Wang", email: "kevin111@gmail.com", password: "123456")
      annie = User.create(first_name: "Annie", last_name: "Lee", email: "Annie222@gmail.com", password: "123456")

      vendor1 = FactoryBot.create(:vendor, online: true, user_id: kevin.id)
      vendor2 = FactoryBot.create(:vendor, online: true, user_id: kevin.id)
      vendor3 = FactoryBot.create(:vendor, online: false, user_id: kevin.id)
      vendor4 = FactoryBot.create(:vendor, online: true, user_id: annie.id)

      expect(Vendor.all.available(kevin.id)).to be_include(vendor1)
      expect(Vendor.all.available(kevin.id)).to be_include(vendor2)
      expect(Vendor.all.available(kevin.id)).not_to be_include(vendor3)
    end
  end
end
