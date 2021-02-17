class ProductListsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product_list, only: %i[edit update destroy]
  load_and_authorize_resource

  def index
    @productLists = current_user.product_lists
  end

  def new
    @product_list = ProductList.new
  end

  def create
    @product_list = ProductList.new(create_params)
    @product_list.user_id = current_user.id
    if @product_list.save
      redirect_to product_lists_path, notice: "新增成功"
    else
      render :new
    end
  end

  def update
    if @product_list.update(update_params)
      redirect_to product_lists_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @product_list.destroy
      redirect_to product_lists_path, notice: "刪除成功"
    end
  end

  def edit; end

  private

  def find_product_list
    @product_list = ProductList.find(params[:id])
  end

  def create_params
    params.require(:product_list).permit(:name, :code, :description, :online)
  end

  def update_params
    params.require(:product_list).permit(:name, :code, :description, :online)
  end
end
