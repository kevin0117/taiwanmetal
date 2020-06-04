class ProductListsController < ApplicationController
  before_action :find_product_list, only: %i[edit update destroy]

  def index
    @productLists = ProductList.all
  end

  def new
    @product_list = ProductList.new
  end

  def create
    @product_list = ProductList.new(product_list_params)
    if @product_list.save
      redirect_to product_lists_path, notice: "新增成功"
    else
      render :new
    end
  end

  def update
    if @product_list.update(product_list_params)
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

  def product_list_params
    params.require(:product_list).permit(:name, :code, :description, :online)
  end
end
