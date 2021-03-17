require 'rails_helper'
# 參考自 "為你自己學 Ruby on Rails"
RSpec.describe Cart, type: :model, cart: true do
  let(:kevin) { FactoryBot.create(:user, first_name: 'Kevin', last_name: 'Wang', password: '123456') }
  let(:po) { FactoryBot.create(:purchase_order, title: "DATE", user_id: kevin.id)}
  let(:product1) { FactoryBot.create(:product, purchase_order_id: po.id) }
  let(:product2) { FactoryBot.create(:product, purchase_order_id: po.id) }
  let(:product3) { FactoryBot.create(:product, purchase_order_id: po.id) }
  let(:cart) { Cart.new }

  describe "出貨單功能" do
    it '將商品放在出貨單裡，然後出貨單裡會有該商品' do
      cart.add_product(product1)

      expect(cart).not_to be_empty
    end

    it "如果加了相同種類的商品到出貨單裡，種類數量不變，但商品的數量會增加" do
      2.times { cart.add_product(product1) }
      3.times { cart.add_product(product2) }

      expect(cart.items.first.quantity).to be 2
      expect(cart.items.second.quantity).to be 3
    end

    it "如果移除相同種類的商品到出貨單裡，種類數量不變，但商品的數量會減少" do
      3.times { cart.add_product(product1) }
      5.times { cart.add_product(product2) }

      2.times { cart.remove_product(product1) }
      2.times { cart.remove_product(product2) }

      expect(cart.items.first.quantity).to be 1
      expect(cart.items.second.quantity).to be 3
    end

    it '將商品放在出貨單裡，然後再刪除該商品時，出貨單會是空白的' do
      3.times { cart.add_product(product1) }
      cart.destroy_product(product1)

      expect(cart).to be_empty
    end

    it "商品可以放到出貨單裡，也可以再拿出來" do
      3.times { cart.add_product(product1)}
      5.times { cart.add_product(product2)}

      expect(cart.items.first.product).to eq product1
      expect(cart.items.second.product).to eq product2
    end

    it "可以計算出貨單裡的重量總和" do
      p1 = FactoryBot.create(:product, weight: 1.0, service_fee: 800.0)
      p2 = FactoryBot.create(:product, weight: 2.0, service_fee: 200.0)

      3.times { cart.add_product(p1) }  # $17400
      2.times { cart.add_product(p2) }  # $20400

      expect(cart.items.first.weight).to eq 3.0
      expect(cart.items.last.weight).to eq 4.0
      expect(cart.total_weight).to eq 7.0
    end

    it "可以計算出貨單裡的工資總和" do
      p1 = FactoryBot.create(:product, weight: 1.0, service_fee: 800.0)
      p2 = FactoryBot.create(:product, weight: 2.0, service_fee: 200.0)

      3.times { cart.add_product(p1) }  # $17400
      2.times { cart.add_product(p2) }  # $20400

      expect(cart.items.first.service_fee).to eq 2400
      expect(cart.items.last.service_fee).to eq 400
      expect(cart.total_service_fee).to eq 2800
    end
  end

  describe "出貨單進階功能" do
    it "可以將出貨單內容轉換成 Hash，存到 Session 裡" do
      3.times { cart.add_product(product1) }
      5.times { cart.add_product(product2) }

      expect(cart.serialize).to eq cart_hash
    end

    it "可以把 Session 的內容（Hash 格式），還原成出貨單的內容" do
      cart = Cart.restore_hash(cart_hash)

      expect(cart.items.first.product).to eq product1
      expect(cart.items.first.quantity).to eq 3
      expect(cart.items.second.product).to eq product2
      expect(cart.items.second.quantity).to eq 5
    end

    private

    def cart_hash
      {
        "items" => [
          {"product_id" => product1.id, "quantity" => 3},
          {"product_id" => product2.id, "quantity" => 5},
        ]
      }
    end
  end
end