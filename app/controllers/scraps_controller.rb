class ScrapsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_scrap, only: [:edit, :update, :show, :destroy, :add_to_cart, :delete_to_cart]
  before_action :set_scrap_ransack_obj
  load_and_authorize_resource

  def index
    params.permit![:format]
    @q = current_user.scraps.ransack(params[:q])
    @scraps = @q.result(distinct: true).includes(:customer).order(id: :desc).page params[:page]

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename = scraps.xlsx"
      }
      format.html { render :index }
    end
  end

  def new
    @scrap = Scrap.new
  end

  def create
    @scrap = Scrap.new(create_params)
    @scrap.user_id = current_user.id

    if @scrap.save
      redirect_to new_scrap_path, notice: "建立成功"
    else
      render :new
    end
  end

  def update
    if @scrap.update(update_params)
      redirect_to scraps_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @scrap.destroy
      redirect_to scraps_path, notice: "刪除成功"
    end
  end

  def edit; end
  def show; end

  def add_to_cart
    cart_scrap = refining_cart.items.find{|item| item.scrap_id == @scrap.id}
    if @scrap.quantity > 0
      if !cart_scrap || @scrap.quantity > 0
        refining_cart.add_scrap(@scrap)
        @scrap.quantity -= 1
        @scrap.in_stock = false if @scrap.quantity == 0
        @scrap.save
        session[:cart9527] = refining_cart.serialize
        flash[:notice] = "加入提煉單"
      else
        flash[:notice] = "超過庫存數量"
      end
      if params[:sale_id] == nil
        redirect_to :controller => 'refine_orders', :action => 'new'
      else
        redirect_to :controller => 'refine_orders', :action => 'edit', :id => params[:scrap_id]
      end
    else
      @scrap.in_stock = false if @scrap.quantity == 0
      redirect_to :controller => 'refine_orders', :action => 'new'
      flash[:notice] = "超過庫存數量"
    end
  end

  def delete_to_cart
    quantity_in_cart = refining_cart.items.find(@scrap.id).first.quantity
    if refining_cart.destroy_scrap(@scrap)
      @scrap.quantity += quantity_in_cart
      session[:cart9527] = refining_cart.serialize
      @scrap.in_stock = true if @scrap.quantity > 0
      @scrap.save
      flash[:notice] = "刪除品項成功"
    else
      flash[:notice] = "刪除品項失敗"
    end
    if params[:scrap_id] == nil
      redirect_to :controller => 'refine_orders', :action => 'new'
    else
      redirect_to :controller => 'refine_orders', :action => 'edit', :id => params[:scrap_id]
    end
  end

  private

  def find_scrap
    @scrap = Scrap.friendly.find(params[:id])
  end

  def create_params
    params.require(:scrap).permit(:collected_date,
                                  :title,
                                  :gross_weight,
                                  :wastage_rate,
                                  :net_weight,
                                  :gold_buying,
                                  :total_price,
                                  :in_stock,
                                  :code,
                                  :customer_id,
                                  :quantity,
                                  :refine_charge)
  end

  def update_params
    params.require(:scrap).permit(:collected_date,
                                  :title,
                                  :gross_weight,
                                  :wastage_rate,
                                  :net_weight,
                                  :gold_buying,
                                  :total_price,
                                  :in_stock,
                                  :code,
                                  :customer_id,
                                  :quantity,
                                  :refine_charge)
  end

  # 設定 Ransack::Search Scrap 的實體
  def set_scrap_ransack_obj
    @q = (user_signed_in?) ? current_user.scraps.ransack(params[:q]) : Scrap.ransack(params[:q])
  end
end
