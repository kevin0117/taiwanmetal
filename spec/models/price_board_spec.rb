require 'rails_helper'

RSpec.describe PriceBoard, type: :model do
  context '當每日貴金屬價格成功建立時..' do
    it '全部欄位正確輸入完成' do
      pb = FactoryBot.build(:price_board)
      expect(pb).to be_valid
    end
  end
end
