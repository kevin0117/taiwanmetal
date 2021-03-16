class PurchaseOrdersController < ApplicationController
  before_action :find_purchase_order, only: %i[update show edit destroy]
  before_action :set_ransack_obj

  def index
    @q = current_user.purchase_orders.ransack(params[:q])
    @purchaseOrders = @q.result(distinct: false).order(id: :desc).order(:id).page(params[:page])  end

  def new
    @purchaseOrder = PurchaseOrder.new
    @purchaseOrder.products.build
  end

  def create
    @purchaseOrder = PurchaseOrder.new(purchase_order_params)
    @purchaseOrder.user_id = current_user.id

    @purchaseOrder.products.each_with_index do |product, index|
      dynamic_tag = params["purchase_order"]["products_attributes"].keys[index]
      product_list_id = params["purchase_order"]["products_attributes"][dynamic_tag]["product_list_id"]
      product.user_id = current_user.id
      product.title = ProductList.find(product_list_id).name
    end

    if @purchaseOrder.save
      redirect_to purchase_orders_path, notice: "建立成功"
    else
      render :new
    end
  end

  def update
    if @purchaseOrder.update(purchase_order_params)
      redirect_to purchase_orders_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @purchaseOrder.destroy
      redirect_to purchase_orders_path, notice: "刪除成功"
    end
  end

  def show
    params.permit![:format]

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename = products.xlsx"
      }
      format.html { render :show }
    end
  end

  def edit; end

  private

  def find_purchase_order
    @purchaseOrder = PurchaseOrder.find(params[:id])
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

  def set_ransack_obj
    @q = (user_signed_in?) ? current_user.purchase_orders.ransack(params[:q]) : PurchaseOrder.ransack(params[:q])
  end
end
