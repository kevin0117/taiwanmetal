require 'rails_helper'

RSpec.describe RefineOrder, type: :model, refine: true do
  context '當銷售成功建立時...' do
      
    it '全部欄位填寫完成' do
      r1 = FactoryBot.create(:refine_order)
      
      expect(r1).to be_valid
    end

    it '日期欄位填寫完成' do
      r1 = FactoryBot.build(:refine_order, request_date: "2020-07-18 23:14:03")
      
      expect(r1).to be_valid
    end  

    it '日期欄位不能是空白' do
      r1 = FactoryBot.build(:refine_order, request_date: "")
    
      expect(r1).not_to be_valid
    end

    it '接收者名稱有填寫' do
      r1 = FactoryBot.create(:refine_order, recipient: "王大明")

      expect(r1).to be_valid
    end

    it '接收者名稱不能是空白' do
      r1 = FactoryBot.build(:refine_order, recipient: '')

      expect(r1).not_to be_valid
      expect{ expect(r1).to be_valid }.to raise_exception(/Recipient can't be blank/)
    end

  end
end

# recipient { Faker::Name.last_name }
