require 'rails_helper'

RSpec.describe Commodity, type: :model, commodity: true do

  context "當委託單成功建立時..." do
    it "全部欄位填寫完成" do
      commodity = FactoryBot.create(:commodity)
      expect(commodity).to be_valid
    end

    it '重量有填寫' do
      commodity = FactoryBot.create(:commodity, weight: "2.33")

      expect(commodity).to be_valid
    end 

    it '重量不能是空白' do
      commodity = FactoryBot.build(:commodity, weight: '')

      expect(commodity).not_to be_valid
      expect{ expect(commodity).to be_valid }.to raise_exception(/Weight 不能為空白/)
    end  

    it '單價有填寫' do
      commodity = FactoryBot.create(:commodity, unit_price: "2.33")

      expect(commodity).to be_valid
    end 

    it '單價不能是空白' do
      commodity = FactoryBot.build(:commodity, unit_price: '')

      expect(commodity).not_to be_valid
      expect{ expect(commodity).to be_valid }.to raise_exception(/Unit price 不能為空白/)
    end 

    it '合計總額有填寫' do
      commodity = FactoryBot.build(:commodity, weight: 10, unit_price: 6000)

      expect(commodity.total_price).to eq 60000
    end

    it '合計總額不能是空白' do
      commodity = FactoryBot.build(:commodity, total_price: '')

      expect(commodity).not_to be_valid
      expect{ expect(commodity).to be_valid }.to raise_exception(/Total price 不能為空白/)
    end 

    it '委託交易有填寫' do
      commodity = FactoryBot.create(:commodity, action: 0)

      expect(commodity).to be_valid
    end 

    it '委託交易不能是空白' do
      commodity = FactoryBot.build(:commodity, action: '')

      expect(commodity).not_to be_valid
      expect{ expect(commodity).to be_valid }.to raise_exception(/Action 不能為空白/)
    end 

    it '委託單狀態為『可成交 open』時, 此單可以『交易』' do
      commodity = FactoryBot.build(:commodity, status: "open")

      expect(commodity).to have_state(:open)
      expect(commodity).to allow_event :trade
      expect(commodity).to transition_from(:open).to(:closed).on_event(:trade)
    end
  
    it '委託單狀態為『可交易 open』時, 此單可以『取消』' do
      commodity = FactoryBot.build(:commodity, status: "open")

      expect(commodity).to have_state(:open)
      expect(commodity).to allow_event :cancel
    end

    it '委託單狀態為『已成交 closed』時, 此單不可以再次『交易』' do
      commodity = FactoryBot.build(:commodity, status: "closed")

      expect(commodity).to have_state(:closed)
      expect(commodity).to_not allow_event :trade
      expect(commodity).not_to transition_from(:closed).to(:open).on_event(:trade)
    end

    it '委託單狀態為『已成交 closed』時, 此單不可以『取消』' do
      commodity = FactoryBot.build(:commodity, status: "closed")

      expect(commodity).to have_state(:closed)
      expect(commodity).to_not allow_event :cancel
      expect(commodity).not_to transition_from(:closed).to(:open).on_event(:cancel)
    end

    it '委託單狀態為『已取消 cancelled』時, 此單不可以再次『交易』' do
      commodity = FactoryBot.build(:commodity, status: "cancelled")

      expect(commodity).to have_state(:cancelled)
      expect(commodity).to_not allow_event :trade
      expect(commodity).not_to transition_from(:cancelled).to(:open).on_event(:trade)
    end

    it '委託單狀態為『已取消 cancelled』時, 此單不可以『取消』' do
      commodity = FactoryBot.build(:commodity, status: "cancelled")

      expect(commodity).to have_state(:cancelled)
      expect(commodity).to_not allow_event :cancel
      expect(commodity).not_to transition_from(:cancelled).to(:open).on_event(:cancel)
    end

    it '可以拿出所有『可成交 open』委託單' do
      commodity1 = FactoryBot.create(:commodity, status: "open")
      commodity2 = FactoryBot.create(:commodity, status: "open")
      commodity3 = FactoryBot.create(:commodity, status: "closed")

      expect(Commodity.all.available).to be_include(commodity1)
      expect(Commodity.all.available).to be_include(commodity2)
      expect(Commodity.all.available).not_to be_include(commodity3)
    end

    it '可以拿出所有個別使用者的『已成交 closed』委託單' do
      kevin = User.create(first_name: "Kevin", last_name: "Wang", email: "kevin111@gmail.com", password: "123456")
      annie = User.create(first_name: "Annie", last_name: "Lee", email: "Annie222@gmail.com", password: "123456")
      
      commodity1 = FactoryBot.create(:commodity, status: "closed", user_id: kevin.id)
      commodity2 = FactoryBot.create(:commodity, status: "open", user_id: kevin.id)
      commodity3 = FactoryBot.create(:commodity, status: "closed", user_id: kevin.id)
      commodity4 = FactoryBot.create(:commodity, status: "closed", user_id: annie.id)

      
      expect(Commodity.all.closed(kevin.id)).to be_include(commodity1)
      expect(Commodity.all.closed(kevin.id)).to be_include(commodity3)
      expect(Commodity.all.closed(kevin.id)).not_to be_include(commodity2)
      expect(Commodity.all.closed(kevin.id)).not_to be_include(commodity4)
    end

  end
end


# job = Job.new
# expect(job).to transition_from(:sleeping).to(:running).on_event(:run)
# expect(job).not_to transition_from(:sleeping).to(:cleaning).on_event(:run)
# expect(job).to have_state(:sleeping)
# expect(job).not_to have_state(:running)
# expect(job).to allow_event :run
# expect(job).to_not allow_event :clean
# expect(job).to allow_transition_to(:running)
# expect(job).to_not allow_transition_to(:cleaning)
# # on_event also accept multiple arguments
# expect(job).to transition_from(:sleeping).to(:running).on_event(:run, :defragmentation)


