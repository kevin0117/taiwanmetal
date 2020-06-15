require 'rails_helper'

RSpec.describe CartItem, type: :model, tag_item: true do
  describe "基本功能" do
    let(:pb) { FactoryBot.create(:price_board, gold_selling: 5000.0) }
    let(:product1) { FactoryBot.create(:product, price_board: pb, weight: 1.0, service_fee: 800.0) }
    let(:product2) { FactoryBot.create(:product, price_board: pb, weight: 2.0, service_fee: 200.0) }
    let(:cart) { Cart.new }

    it "每個 Cart Item 都可以計算它自己的金額（小計)" do
      c1 = CartItem.new(product1.id, 2)
      
      3.times { cart.add_product(product1) }  # $17400
      2.times { cart.add_product(product2) }  # $20400

      expect(cart.items.first.total_price).to eq 17400
      expect(cart.items.last.total_price).to eq 20400
    end
  end

end

