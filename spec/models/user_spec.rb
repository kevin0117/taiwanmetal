require 'rails_helper'

RSpec.describe User, type: :model do
  context '當使用者建立成功時..' do
    it '全部欄位正確填寫完成' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
    it '電子信箱有填寫' do
      user = FactoryBot.build(:user, email: 'sample@gamil.com')
      expect(user).to be_valid
    end
    it '電子信箱不能是空白' do
      user = FactoryBot.build(:user, email: '')
      expect(user).not_to be_valid
      expect { expect(user).to be_valid }.to raise_exception(/電子信箱 不能為空白/)
    end
    it '密碼有填寫' do
      user = FactoryBot.build(:user, password: '123456')
      expect(user).to be_valid
    end
    it '密碼不能是空白' do
      user = FactoryBot.build(:user, password: '')
      expect(user).not_to be_valid
      expect { expect(user).to be_valid }.to raise_exception(/密碼 不能為空白/)
    end
  end
end
