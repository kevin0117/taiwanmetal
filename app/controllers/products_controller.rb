class ProductsController < ApplicationController
  before_action :find_product, only: %i[edit update show destroy add_to_cart delete_to_cart]
  
  def index
    @products = Product.all.includes(:vendor, :product_list)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.title = ProductList.find(params[:product][:product_list_id]).name
    @product.user_id = current_user.id
    # byebug
    if @product.save
      redirect_to products_path, notice: "商品建立成功"
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "更新成功" 
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "刪除成功"
    end
  end

  def edit; end
  def show; end
  
  private

  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, 
                                    :weight, 
                                    :cost, 
                                    :service_fee, 
                                    :barcode,
                                    :on_sell, 
                                    :code,
                                    :vendor_id,
                                    :product_list_id,
                                    :description)
  end
end