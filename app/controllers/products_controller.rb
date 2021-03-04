class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: %i[edit update show destroy add_to_cart delete_to_cart decrease_to_cart]
  before_action :set_ransack_obj
  load_and_authorize_resource

  def index
    params.permit![:format]
    @q = current_user.products.ransack(params[:q])
    @products = @q.result(distinct: true).order(id: :desc).includes(:vendor, :product_list).order(:id).page(params[:page])

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename = products.xlsx"
      }
      format.html { render :index }
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(create_params)
    @product.title = ProductList.find(params[:product][:product_list_id]).name
    @product.user_id = current_user.id
    rand_id = rand().to_s.scan(/[0-9]/).join[0...12]

    if @product.save
      generate_barcode(rand_id, @product.id)

      # attach the barcode image from the images folder and store in S3 AWS
      @product.barcode.attach(io: File.open("#{Rails.root}/app/assets/images/barcode-#{@product.id}.png"),
                              filename: "barcode-#{@product.id}.png",
                              content_type: 'image/png')

      redirect_to products_path, notice: "商品建立成功"
    else
      render :new
    end
  end

  def update
    @product.title = ProductList.find(params[:product][:product_list_id]).name

    if @product.update(update_params)
      redirect_to products_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      @product.barcode.purge if @product.barcode.attached?
      # @product.description.purge if !@product.description.blank?
      @product.description.destroy! if !@product.description.blank?
      # @product.description.delete if !@product.description.blank?
      redirect_to products_path, notice: "刪除成功"
    end
  end

  def add_to_cart
    cart_product = current_cart.items.find{|item| item.product_id == @product.id}
    if @product.quantity > 0
      current_cart.add_product(@product)
      @product.decrement(:quantity)
      @product.on_sell = false if @product.quantity == 0
      @product.save
      session[:cart0117] = current_cart.serialize
      # redirect_to :controller => 'sales', :action => 'new'
      redirect_to controller: :sales, action: :new
      flash[:notice] = "加入出貨單"
    else
      @product.on_sell = false if @product.quantity == 0
      # redirect_to :controller => 'sales', :action => 'new'
      redirect_to controller: :sales, action: :new
      flash[:notice] = "超過庫存數量"
    end
  end

  def delete_to_cart
    quantity_in_cart = current_cart.items.find(@product.id).first.quantity
    if current_cart.destroy_product(@product)
      @product.quantity += quantity_in_cart
      @product.on_sell = true if @product.quantity > 0
      @product.save
      # redirect_to :controller => 'sales', :action => 'new'
      redirect_to controller: :sales, action: :new
      flash[:notice] = "刪除品項成功"
    else
      # redirect_to :controller => 'sales', :action => 'new'
      redirect_to controller: :sales, action: :new
      flash[:notice] = "刪除品項失敗"
    end
    session[:cart0117] = current_cart.serialize
  end

  def decrease_to_cart
    if current_cart.remove_product(@product)
      @product.quantity += 1
      @product.update(on_sell: true) if @product.quantity > 0
      @product.save
      # redirect_to :controller => 'sales', :action => 'new'
      redirect_to controller: :sales, action: :new
      flash[:notice] = "減少品項成功"
    else
      # redirect_to :controller => 'sales', :action => 'new'
      redirect_to controller: :sales, action: :new
      flash[:notice] = "不能為負數"
    end
    session[:cart0117] = current_cart.serialize
  end

  def edit; end
  def show; end

  private

  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def create_params
    params.require(:product).permit(:title,
                                    :weight,
                                    :cost,
                                    :service_fee,
                                    :barcode,
                                    :on_sell,
                                    :code,
                                    :quantity,
                                    :vendor_id,
                                    :product_list_id,
                                    :customer_id,
                                    :price_board_id,
                                    :description)
  end

  def update_params
    params.require(:product).permit(:title,
                                    :weight,
                                    :cost,
                                    :service_fee,
                                    :barcode,
                                    :on_sell,
                                    :code,
                                    :quantity,
                                    :vendor_id,
                                    :product_list_id,
                                    :customer_id,
                                    :price_board_id,
                                    :description)
  end

  def set_ransack_obj
    @q = (user_signed_in?) ? current_user.products.ransack(params[:q]) : Product.ransack(params[:q])
  end
end