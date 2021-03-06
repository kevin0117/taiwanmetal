class VendorsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_vendor, only: %i[edit update destroy]
  load_and_authorize_resource

  def index
    @vendors = current_user.vendors
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(create_params)
    @vendor.user_id = current_user.id

    if @vendor.save
      redirect_to vendors_path, notice: "新增成功"
    else
      render :new
    end
  end

  def update
    if @vendor.update(update_params)
      redirect_to vendors_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @vendor.destroy
      redirect_to vendors_path, notice: "刪除成功"
    end
  end

  def edit; end

  private

  def find_vendor
    @vendor = Vendor.find(params[:id])
  end

  def create_params
    params.require(:vendor).permit(:name, :description, :online)
  end

  def update_params
    params.require(:vendor).permit(:name, :description, :online)
  end
end