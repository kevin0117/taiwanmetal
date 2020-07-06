class ApplicationController < ActionController::Base
  helper_method :current_cart, :find_quantity
  before_action :configure_permitted_parameters, if: :devise_controller?

  def generate_barcode(text, id)
    barcode = Barby::Code39.new(text, true)
    outputter = Barby::PngOutputter.new(barcode)
    ​File.open("#{Rails.root}/app/assets/images/barcode-#{id}.png", 'wb'){|f| f.write outputter.to_png }
  end

  def current_cart
    @cart = @cart || Cart.restore_hash(session[:cart0117])
  end

  def find_quantity(product)
    current_cart.items.find{|item| item.product_id == product.id}.quantity
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
