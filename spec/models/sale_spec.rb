require 'rails_helper'

RSpec.describe Sale, type: :model, sale: true do
  context '當銷售成功建立時...'
  it '全部欄位正確填寫完成' do
    s1 = FactoryBot.create(:sale)

    expect(s1).to be_valid
  end
  it '日期欄位填寫完成' do
    s1 = FactoryBot.build(:sale, sale_date: "2020-07-18 23:14:03")

    expect(s1).to be_valid
  end

  it '日期欄位不能是空白' do
    s1 = FactoryBot.build(:sale, sale_date: "")

    expect(s1).not_to be_valid
  end

  it '黃金賣出價格有填寫' do
    s1 = FactoryBot.create(:sale, gold_selling: "6000")

    expect(s1).to be_valid
  end

  it '黃金賣出價格不能是空白' do
    s1 = FactoryBot.build(:sale, gold_selling: "")

    expect(s1).not_to be_valid
    expect{ expect(s1).to be_valid }.to raise_exception(/Gold selling can't be blank/)
  end

  it '黃金買入價格有填寫' do
    s1 = FactoryBot.create(:sale, gold_buying: "6000")

    expect(s1).to be_valid
  end

  it '黃金買入價格不能是空白' do
    s1 = FactoryBot.build(:sale, gold_buying: "")

    expect(s1).not_to be_valid
    expect{ expect(s1).to be_valid }.to raise_exception(/Gold buying can't be blank/)
  end

  it '銷售總額不能是空白' do
    s1 = FactoryBot.build(:sale, total_price: "")
    expect(s1).not_to be_valid
    expect{ expect(s1).to be_valid }.to raise_exception(/Total price can't be blank/)

  end
end