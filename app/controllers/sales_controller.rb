class SalesController < ApplicationController
  before_action :find_sale, only: %i[edit update show destroy]
  before_action :find_product, only: %i[remove add decrease]
  before_action :set_sale, only: %i[decrease add remove]
  before_action :set_all_products_in_order, only: %i[new create edit]

  def index
    @sales = Sale.all.order(sale_date: :desc)
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user_id = current_user.id
    
    if @sale.save
      @product = Product.find(params[:sale][:product_id])

      current_cart.product_list.map{|product| 
        if product.quantity <= 0
          product.update(on_sell: false)
        end
      }

      current_cart.items.map{ |item| 
        Manifest.create(product_id: item.product_id,
                        sale_id: @sale.id,
                        quantity: item.quantity)
      }
      session[:cart0117] = nil 
      redirect_to sales_path, notice: "銷貨新增成功"
    else
      render :new
    end
  end

  def update
    if @sale.update(sale_params)
      redirect_to sales_path, notice: "銷貨編輯成功"
    else
      render :edit 
    end
  end

  def destroy
    @sale.manifests.map{ |manifest| 
      @sale.products.map{ |product|
        if manifest.product_id == product.id
          product.quantity += manifest.quantity
          product.on_sell = true
          product.save
        end
      }
    }  
    if @sale.destroy
      redirect_to sales_path, notice: "銷貨刪除成功"
    end
  end

  def remove
    target_manifest = @sale.manifests.find_by(product_id: @product.id)
    @product.quantity += target_manifest.quantity
    @product.save
    @sale.products.delete(@product)
    
    redirect_to :controller => 'sales', :action => 'edit', :id => params[:sale_id]
  end

  def add
    found_product = @sale.products.find{ |product| 
                      product.id == @product.id 
                    }

    if found_product && @product.quantity > 0
      target_manifest = @sale.manifests.find_by(product_id: found_product.id)
      target_manifest.quantity += 1

      found_product.quantity -= 1
      found_product.update(on_sell: false) if found_product.quantity <= 0
      found_product.save
      target_manifest.save
      
      flash[:notice] = "加入成功"
    elsif found_product && @product.quantity <= 0
      flash[:notice] = "超過庫存量"
    elsif !found_product && @product.quantity > 0
      @sale.products << @product
      @product.quantity -= 1
      @product.save
      flash[:notice] = "加入成功"
    elsif !found_product && @product.quantity <= 0
      flash[:notice] = "超過庫存量"
    end
    
    redirect_to :controller => 'sales', :action => 'edit', :id => params[:sale_id]
  end


  def decrease
    found_product = @sale.products.find{ |product| 
      product.id == @product.id 
    }
    target_manifest = @sale.manifests.find_by(product_id: found_product.id)
    
    if found_product && target_manifest.quantity > 0
      target_manifest.quantity -= 1
      @product.quantity += 1
      @product.update(on_sell: true) if @product.quantity > 0
      @product.save
      target_manifest.save
      flash[:notice] = "移除成功"
    else
      flash[:notice] = "移除失敗"
    end
    
    redirect_to :controller => 'sales', :action => 'edit', :id => params[:sale_id] 
    
  end

  def edit; end
  def show; end

  private

  def find_sale
    @sale = Sale.find(params[:id])
  end

  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def set_all_products_in_order
    @products = Product.all.order(:id)
  end

  def set_sale
    @sale = Sale.find(params[:sale_id])
  end

  def sale_params
    params.require(:sale).permit(:sale_date,
                                 :gold_selling,
                                 :gold_buying,
                                 :exchange_weight, 
                                 :wastage_rate,
                                 :net_weight,
                                 :payment_method,
                                 :service_fee,
                                 :weight,
                                 :total_price,
                                 :product_id,
                                 :customer_id,
                                 :user_id)
                                 
  end
end
