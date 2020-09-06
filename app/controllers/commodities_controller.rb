class CommoditiesController < ApplicationController
  before_action :find_commodity, only: %i[edit show update destroy deal]
  # include CurrentPrice
  # before_action :show_price, only: %i[index]
  
  def index
    @commodities = Commodity.order(id: :desc)
    @commodity = Commodity.new
  end

  def new
    @commodity = Commodity.new
  end

  def create
    @commodity = Commodity.new(commodity_params)
    @commodity.user_id = current_user.id
    
    if @commodity.save
      SendCommodityWorker.perform_async(@commodity.id)
      redirect_to commodities_path, notice: "新增成功"
    else
      render :new
    end
  end

  def update
    if @commodity.update(commodity_params)
      redirect_to commodities_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @commodity.may_cancel?
      @commodity.destroy
      @commodity.cancel!
      RemoveCommodityWorker.perform_async(@commodity.id)
      redirect_to commodities_path, notice: "取消成功"
    else
      redirect_to commodities_path, notice: "此委託單已成交"
    end
  end

  def deal
    @commodity.trade!
    @commodity.closer_id = current_user.id
    @commodity.save
    RemoveCommodityWorker.perform_async(@commodity.id)
    # 寄給結單使用者
    MailWorker.perform_async(@commodity.closer_id)
    # 寄給掛單委託者
    MailWorker.perform_async(@commodity.user_id)
    # 寄給系統管理員
    MailAdminWorker.perform_async(1, @commodity.user_id, @commodity.closer_id)

    redirect_to commodities_path, notice: "下單成功"
  end

  def edit; end
  def show; end

  private

  def find_commodity
    @commodity = Commodity.find(params[:id])
  end

  def commodity_params                                                            
    params.require(:commodity).permit(:weight,
                                      :unit_price, 
                                      :total_price, 
                                      :status, 
                                      :action,
                                      :user_id)
  end
end
