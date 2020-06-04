class CustomersController < ApplicationController
  before_action :find_customer, only: %i[edit update show destroy]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: "客戶新增成功"
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
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

  def customer_params
    params.require(:customer).permit(:name, :description, :online, :product_id, :user_id)
  end
end