class RefineOrdersController < ApplicationController
  before_action :set_scrap_ransack_obj
  before_action :find_refine_order, only: %i[edit update show destroy report]
  before_action :find_scrap, only: %i[remove add decrease]
  before_action :set_refine_order, only: %i[decrease add remove]

  def index
    @q = current_user.refine_orders.ransack(params[:q])
    @refineOrders = @q.result(distinct: true).page(params[:page])
  end

  def new
    @refine_order = RefineOrder.new
    @scraps = @q.result(distinct: true)
  end

  def edit
    @scraps = @q.result(distinct: true)
  end
  
  def create
    @scrap = @q.result(distinct: true)
    @refine_order = RefineOrder.new(refine_order_params)
    @refine_order.user_id = current_user.id
    # byebug
    if @refine_order.save
      @scrap = Scrap.find(params[:refine_order][:scrap_id])

      refining_cart.scrap_list.map{|scrap|
        if scrap.quantity <= 0
          scrap.update(in_stock: false)
        end
      }

      refining_cart.items.map{ |item| 
      RefineList.create(scrap_id: item.scrap_id,
                        refine_order_id: @refine_order.id,
                        quantity: item.quantity)
                    }
      session[:cart9527] = nil 
      redirect_to refine_orders_path, notice: "提煉單建立成功"
    else
      render :new
    end
  end

  def remove
    target_refine_list = @refine_order.refine_lists.find_by(scrap_id: @scrap.id)
    @scrap.quantity += target_refine_list.quantity
    @scrap.update(in_stock: true) if @scrap.quantity > 0

    @scrap.save
    @refine_order.scraps.delete(@scrap)
    
    redirect_to :controller => 'refine_orders', :action => 'edit', :id => params[:refine_order_id]
  end

  def add
    found_scrap = @refine_order.scraps.find{ |scrap| 
                      scrap.id == @scrap.id 
                    }
    if found_scrap && @scrap.quantity > 0 
      target_refine_order = @refine_order.refine_lists.find_by(scrap_id: found_scrap.id)
      target_refine_order.quantity += 1
      
      found_scrap.quantity -= 1
      found_scrap.update(in_stock: false) if found_scrap.quantity <= 0
      
      found_scrap.save
      target_refine_order.save
      
      flash[:notice] = "加入成功"
    elsif found_scrap && @scrap.quantity <= 0
      flash[:notice] = "超過庫存量"
    elsif !found_scrap && @scrap.quantity > 0
      @refine_order.scraps << @scrap
      @scrap.quantity -= 1
      @scrap.update(in_stock: false) if @scrap.quantity <= 0
      
      @scrap.save
      flash[:notice] = "加入成功"
    elsif !found_scrap && @scrap.quantity <= 0
      flash[:notice] = "超過庫存量"
    end
    
    redirect_to :controller => 'refine_orders', :action => 'edit', :id => params[:refine_order_id]
  end

  def decrease
    found_scrap = @refine_order.scraps.find{ |scrap| 
      scrap.id == @scrap.id 
    }
    target_refine_list = @refine_order.refine_lists.find_by(scrap_id: found_scrap.id)
    
    if found_scrap && target_refine_order.quantity > 0
      target_refine_list.quantity -= 1
      @scrap.quantity += 1
      @scrap.update(in_stock: true) if @scrap.quantity > 0
      @scrap.save
      target_refine_list.save
      flash[:notice] = "移除成功"
    else
      flash[:notice] = "移除失敗"
    end
    
    redirect_to :controller => 'refine_orders', :action => 'edit', :id => params[:refine_order_id] 
    
  end

  def update
    if @refine_order.update(refine_order_params)
      redirect_to refine_orders_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @refine_order.destroy
      redirect_to refine_orders_path, notice: "刪除成功"
    end
  end

  def report
    
  end

  private

  def refine_order_params
    params.require(:refine_order).permit(:request_date, 
                                         :status, 
                                         :refine_fee, 
                                         :result_weight, 
                                         :result_purity,
                                         :note,
                                         :recipient,
                                         :scrap_id,
                                         :total_gross_weight,
                                         :total_net_weight)
  end

  def find_refine_order
    @refine_order = RefineOrder.find(params[:id])
  end

  def find_scrap
    @scrap = Scrap.friendly.find(params[:id])
  end

  def set_refine_order
    @refine_order = RefineOrder.find(params[:refine_order_id])
  end

  # 設定 Ransack::Search Scrap 的實體
  def set_scrap_ransack_obj
    @q = (user_signed_in?) ? current_user.scraps.ransack(params[:q]) : Scrap.ransack(params[:q])
  end
end
