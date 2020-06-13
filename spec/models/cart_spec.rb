require 'rails_helper'
# 參考自 "為你自己學 Ruby on Rails"
RSpec.describe Cart, type: :model, tag_cart: true do
  let(:product1) { FactoryBot.create(:product) }
  let(:product2) { FactoryBot.create(:product) }
  let(:product3) { FactoryBot.create(:product) }
  let(:cart) { Cart.new }

  describe "出貨單功能" do
    it '將商品放在出貨單裡，然後出貨單裡會有該商品' do
      cart.add_product(product1)

      expect(cart).not_to be_empty
    end

    it '將商品放在出貨單裡，再移除該商品時出貨單裡是空白的' do
      cart.add_product(product1)
      cart.remove_product(product1)

      expect(cart).to be_empty
    end

    it "如果加了相同種類的商品到出貨單裡，商品項目（CartItem）並不會增加，但商品的數量會改變" do
      3.times { cart.add_product(product1)}
      5.times { cart.add_product(product2)}
      2.times { cart.add_product(product3)}

      expect(cart.items.length).to be 3
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.quantity).to be 5
    end

    it "商品可以放到出貨單裡，也可以再拿出來" do
      3.times { cart.add_product(product1)}
      5.times { cart.add_product(product2)}

      expect(cart.items.first.product).to eq product1
      expect(cart.items.second.product).to eq product2
    end

    it "可以計算出貨單裡的總消費金額" do
      pb = FactoryBot.create(:price_board, gold_selling: 5000.0)
      p1 = FactoryBot.create(:product, price_board: pb, weight: 1.0, service_fee: 800.0)
      p2 = FactoryBot.create(:product, price_board: pb, weight: 2.0, service_fee: 200.0)
      
      3.times { cart.add_product(p1) }  # $17400
      2.times { cart.add_product(p2) }  # $20400

      expect(cart.items.first.total_price).to eq 17400
      expect(cart.items.last.total_price).to eq 20400
      expect(cart.total_price).to eq 37800
    end

    it "可以將出貨單內容轉換成 Hash，存到 Session 裡" do
      3.times { cart.add_product(product1)}
      5.times { cart.add_product(product2)}

      expect(cart.serialize).to eq cart_hash
    end
    
    it "可以把 Session 的內容（Hash 格式），還原成出貨單的內容" do
      cart = Cart.restore_hash(cart_hash)
      
      expect(cart.items.first.product_id).to be product1.id
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.product_id).to be product2.id
      expect(cart.items.second.quantity).to be 5
    end

    private

    def cart_hash
      {
        items: [
          {product_id: product1.id, quantity: 3},
          {product_id: product2.id, quantity: 5},
        ]
      }
    end
  end
end