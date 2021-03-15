class PurchaseOrdersController < ApplicationController
  before_action :find_purchase_order, only: %i[update show edit destroy]

  def index
    @purchaseOrders = PurchaseOrder.all
  end

  def new
    @purchase_order = PurchaseOrder.new
    @purchase_order.products.build
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    @purchase_order.user_id = current_user.id

    @purchase_order.products.each_with_index do |product, index|
      dynamic_tag = params["purchase_order"]["products_attributes"].keys[index]
      product_list_id = params["purchase_order"]["products_attributes"][dynamic_tag]["product_list_id"]
      product.user_id = current_user.id
      product.title = ProductList.find(product_list_id).name
    end

    if @purchase_order.save
      redirect_to purchase_orders_path, notice: "建立成功"
    else
      render :new
    end
  end

  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to purchase_orders_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @purchase_order.destroy
      redirect_to purchase_orders_path, notice: "刪除成功"
    end
  end

  def show; end

  def edit; end

  private

  def find_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def purchase_order_params
    params.require(:purchase_order).permit(
        :title,
        :code,
        products_attributes: [
          :id,
          :title,
          :weight,
          :total_weight,
          :cost,
          :service_fee,
          :total_service_fee,
          :barcode,
          :on_sell,
          :code,
          :quantity,
          :vendor_id,
          :product_list_id,
          :customer_id,
          :price_board_id,
          :product_cabinet_id,
          :description,
          :_destroy])
  end
end
