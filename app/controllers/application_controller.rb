class ApplicationController < ActionController::Base
  helper_method :current_cart, :find_quantity, :refining_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  around_action :switch_locale

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/404.html",
    layout: false,
    status: 404
    # redirect_to root_path, notice: I18n.t('devise.failure.unauthorized')
  end

  # 設定語系
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # 語係切換
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  # 使用者選擇語係後可持續在其他頁面使用該語系
  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  # 從子網域取得locale code
  def extract_locale_from_tld
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def generate_barcode(number, id)
    barcode = Barby::EAN13.new(number)
    outputter = Barby::PngOutputter.new(barcode)

    File.open("#{Rails.root}/app/assets/images/barcode-#{id}.png", 'wb'){|f| f.write outputter.to_png}
  end

  def current_cart
    @cart = @cart || Cart.restore_hash(session[:cart0117])
  end

  def refining_cart
    @refine_cart = @refine_cart || RefineCart.restore_hash(session[:cart9527])
  end

  def find_quantity(product)
    current_cart.items.find{|item| item.product_id == product.id}.quantity
  end

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html",
    layout: false,
    status: 404
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end

  # def generate_barcode(text, id)
  #   barcode = Barby::Code39.new(text, true)
  #   outputter = Barby::PngOutputter.new(barcode)
  #   File.open("#{Rails.root}/public/barcode-#{id}.png", 'wb'){|f| f.write outputter.to_png }
  # end

  # def generate_barcode(text, id)
  #   barcode = Barby::Code93.new(text)
  #   outputter = Barby::PngOutputter.new(barcode)
  #   File.open("#{Rails.root}/app/assets/images/barcode-#{id}.png", 'wb'){|f| f.write outputter.to_png }
  # end