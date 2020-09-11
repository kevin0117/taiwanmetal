require 'rails_helper'

RSpec.describe RefineOrder, type: :model, refine: true do
  context '當提煉訂單成功建立時...' do
      
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
      expect{ expect(r1).to be_valid }.to raise_exception(/Recipient 不能為空白/)
    end

    it '提煉狀態為『等待中 pending』時, 此單可向工廠『通知 notify』接單' do
      refine_order = FactoryBot.build(:refine_order, status: "pending")
      
      expect(refine_order).to have_state(:pending)
      expect(refine_order).to allow_event :notify
      expect(refine_order).to transition_from(:pending).to(:scheduling).on_event(:notify)
    end

    it '提煉狀態為『等待中 pending』時, 此單可向工廠『取消』訂單' do
      refine_order = FactoryBot.build(:refine_order, status: "pending")

      expect(refine_order).to have_state(:pending)
      expect(refine_order).to allow_event :cancel
    end

    it '提煉狀態為『排程中 scheduling』時, 提煉工廠可『回覆 reply』訂單' do
      refine_order = FactoryBot.build(:refine_order, status: "scheduling")
      
      expect(refine_order).to have_state(:scheduling)
      expect(refine_order).to allow_event :reply
      expect(refine_order).to transition_from(:scheduling).to(:refining).on_event(:reply)
    end

    it '提煉狀態為『提煉中 refining』時, 此單可向委託者『報告 report』提煉結果' do
      refine_order = FactoryBot.build(:refine_order, status: "refining")
      
      expect(refine_order).to have_state(:refining)
      expect(refine_order).to allow_event :report
      expect(refine_order).to transition_from(:refining).to(:closing).on_event(:report)
    end
  end
end

# recipient { Faker::Name.last_name }
