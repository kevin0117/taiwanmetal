require 'rails_helper'

RSpec.describe 'Utils API', type: :request, api: true do
  context '在新增銷售單時，有換金需求時...' do
    annie = User.create(first_name: 'Annie', last_name: 'Wang', email: 'annie111@gmail.com', password: '123456')
    kevin = User.create(first_name: 'Kevin', last_name: 'Wang', email: 'kevin111@gmail.com', password: '123456', id: '1')
    customer1 = FactoryBot.create(:customer, name: 'Kevin', online: true)
    user1 = FactoryBot.create(:user, first_name: 'Annie', last_name: 'Wang', password: '123456')

    it '存入待提煉舊金『成功』，如果欄位填寫完成' do
      post '/api/v1/transfer', params: { transfer: { collected_date: '2020-12-22 23:20:00',
                                                     customer_id: customer1.id,
                                                     title: '待提煉換金-舊料',
                                                     title1: '待提煉換金-買料',
                                                     gross_weight: '9',
                                                     scrap_weight: '4',
                                                     wastage_rate: '0.95',
                                                     net_weight: '1.42',
                                                     gold_buying: '5900',
                                                     total_price: '90',
                                                     user_id: user1.id } }

      expect(response.body).to include('ok')
    end

    it '存入待提煉舊金『失敗』，如果買金重量為負值' do
      post '/api/v1/transfer', params: { transfer: { collected_date: '2020-12-22 23:20:00',
                                                     customer_id: customer1.id,
                                                     title: '待提煉換金-舊料',
                                                     title1: '待提煉換金-買料',
                                                     gross_weight: '2',
                                                     scrap_weight: '-1',
                                                     wastage_rate: '0.95',
                                                     net_weight: '1.42',
                                                     gold_buying: '5900',
                                                     total_price: '90',
                                                     user_id: user1.id } }

      expect(response.body).to include('fail')
    end
  end
end
