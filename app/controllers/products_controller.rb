class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: %i[edit update show destroy add_to_cart delete_to_cart decrease_to_cart]
  before_action :find_price_board_id, only: %i[edit update add_to_cart delete_to_cart decrease_to_cart]
  before_action :set_ransack_obj

  def index
    @q = current_user.products.ransack(params[:q])
    @products = @q.result(distinct: true).order(id: :desc).includes(:vendor, :product_list).order(:id).page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.title = ProductList.find(params[:product][:product_list_id]).name
    @product.user_id = current_user.id

    today_price_board = PriceBoard.find_by(price_date: Date.today)

    @product.price_board_id = if today_price_board
                                today_price_board.id
                              elsif PriceBoard.last.present? 
                                PriceBoard.last.id
                              else
                                redirect_to new_price_board_path, notice: "請先設定今日價格"
                              end

    if @product.save
      # create barcode image by using the product's code and its id
      generate_barcode(@product.code.to_s, @product.id)
      
      # attach the barcode image from the public folder and store in S3 AWS
      @product.barcode.attach(io: File.open("#{Rails.root}/public/barcode-#{@product.id}.png"),
                              filename: "barcode-#{@product.id}.png",
                              content_type: 'image/png')
    
      redirect_to products_path, notice: "商品建立成功"
    else
      render :new
    end
  end
 
  def update
    @product.title = ProductList.find(params[:product][:product_list_id]).name
   
    if @product.update(product_params)
      redirect_to products_path, notice: "更新成功" 
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      # byebug
      @product.barcode.purge if @product.barcode.attached?
      # @product.description.purge if !@product.description.blank?
      @product.description.destroy! if !@product.description.blank?
      # @product.description.delete if !@product.description.blank?
      redirect_to products_path, notice: "刪除成功"
    end
  end

  def add_to_cart
    cart_product = current_cart.items.find{|item| item.product_id == @product.id}
    if @product.quantity != 0
      if !cart_product || @product.quantity > 0
        current_cart.add_product(@product)
        @product.quantity -= 1
        @product.save
        session[:cart0117] = current_cart.serialize
        flash[:notice] = "加入出貨單"
      else
        flash[:notice] = "超過庫存數量"
      end
      if params[:sale_id] == nil
        redirect_to :controller => 'sales', :action => 'new'
      else
        redirect_to :controller => 'sales', :action => 'edit', :id => params[:sale_id]
      end
    end
  end

  def delete_to_cart
    quantity_in_cart = current_cart.items.find(@product.id).first.quantity
    if current_cart.destroy_product(@product)
      @product.quantity += quantity_in_cart
      session[:cart0117] = current_cart.serialize      
      @product.save 
      flash[:notice] = "刪除品項成功"
    else
      flash[:notice] = "刪除品項失敗"
    end
    if params[:sale_id] == nil
      redirect_to :controller => 'sales', :action => 'new'
    else
      redirect_to :controller => 'sales', :action => 'edit', :id => params[:sale_id]
    end
  end

  def decrease_to_cart
    if current_cart.remove_product(@product)
      @product.quantity += 1
      @product.save  
      flash[:notice] = "減少品項成功"
    else
      flash[:notice] = "不能為負數"
    end

    session[:cart0117] = current_cart.serialize
    if params[:sale_id] == nil
      redirect_to :controller => 'sales', :action => 'new'
    else
      redirect_to :controller => 'sales', :action => 'edit', :id => params[:sale_id]
    end
  end

  def edit; end
  def show; end
  
  private

  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def find_price_board_id
    today_price_board = PriceBoard.find_by(price_date: Date.today)

    @product.price_board_id = if today_price_board
                          today_price_board.id
                        elsif PriceBoard.last.present? 
                          PriceBoard.last.id
                        else
                          redirect_to new_price_board_path, notice: "請先設定今日價格"
                        end
  end

  def product_params
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