require 'rails_helper'

# 參考自 "為你自己學 Ruby on Rails"
RSpec.describe CartItem, type: :model, cart_item: true do
  describe "CartItem 基本功能" do
    let(:pb) { FactoryBot.create(:price_board, gold_selling: 5000.0) }
    let(:product1) { FactoryBot.create(:product, weight: 1.0, service_fee: 800.0) }
    let(:product2) { FactoryBot.create(:product, weight: 2.0, service_fee: 200.0) }
    let(:cart) { Cart.new }

    it "每個 CartItem 都可以計算它自己的重量（小計)" do
      c1 = CartItem.new(product1.id, 2)

      3.times { cart.add_product(product1) }  # 3.0
      2.times { cart.add_product(product2) }  # 4.0

      expect(cart.items.first.weight).to eq 3.0
      expect(cart.items.last.weight).to eq 4.0
    end

    it "每個 CartItem 都可以計算它自己的工資（小計)" do
      c1 = CartItem.new(product1.id, 2)

      3.times { cart.add_product(product1) }  # 2400
      2.times { cart.add_product(product2) }  # 400

      expect(cart.items.first.service_fee).to eq 2400
      expect(cart.items.last.service_fee).to eq 400
    end
  end
end
