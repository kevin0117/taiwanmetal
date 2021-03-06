class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_customer, only: %i[edit update show destroy]
  load_and_authorize_resource

  def index
    @customers = current_user.customers
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(create_params)
    @customer.user_id = current_user.id
    if @customer.save
      redirect_to customers_path, notice: "客戶新增成功"
    else
      render :new
    end
  end

  def update
    if @customer.update(update_params)
      redirect_to customers_path, notice: "客戶編輯成功"
    else
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path, notice: "客戶刪除成功"
    end
  end

  def edit; end

  def show; end

  private

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def create_params
    params.require(:customer).permit(:name, :description, :online, :product_id, :user_id)
  end

  def update_params
    params.require(:customer).permit(:name, :description, :online, :product_id, :user_id)
  end
end