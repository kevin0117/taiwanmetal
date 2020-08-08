class ApplicationController < ActionController::Base
  helper_method :current_cart, :find_quantity
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_ransack_obj

  def generate_barcode(text, id)
    barcode = Barby::Code39.new(text, true)
    outputter = Barby::PngOutputter.new(barcode)
    File.open("#{Rails.root}/public/barcode-#{id}.png", 'wb'){|f| f.write outputter.to_png }
    # @product.barcode.attach(io: File.open('#{Rails.root}/public/barcode-#{id}.png'), filename: 'barcode-#{id}.png')
  end

  def current_cart
    @cart = @cart || Cart.restore_hash(session[:cart0117])
  end

  def find_quantity(product)
    current_cart.items.find{|item| item.product_id == product.id}.quantity
  end

  # 設定Ransack::Search 的實體
  def set_ransack_obj
    @q = (user_signed_in?) ? current_user.products.ransack(params[:q]) : Product.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
