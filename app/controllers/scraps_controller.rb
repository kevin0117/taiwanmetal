class ScrapsController < ApplicationController
  before_action :find_scrap, only: [:edit, :update, :show, :destroy]

  def index
    @scraps = current_user.scraps.order(collected_date: :desc)
  end

  def new
    @scrap = Scrap.new
  end

  def create
    @scrap = Scrap.new(scrap_params)
    @scrap.user_id = current_user.id

    if @scrap.save
      redirect_to new_scrap_path, notice: "建立成功"
    else
      render :new
    end
  end

  def update
    if @scrap.update(scrap_params)
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

  private

  def find_scrap
    @scrap = Scrap.friendly.find(params[:id])
  end

  def scrap_params
    params.require(:scrap).permit(:collected_date,
                                  :title,
                                  :gross_weight, 
                                  :wastage_rate, 
                                  :net_weight, 
                                  :gold_buying,
                                  :total_price, 
                                  :in_stock,
                                  :code,
                                  :customer_id)
  end
end
