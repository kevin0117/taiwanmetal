class User < ApplicationRecord
  has_many :products
  has_many :sales
  has_many :scraps
  has_many :vendors
  has_many :customers
  has_many :price_boards
  has_many :product_lists
  has_many :refine_orders
  has_many :commodities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  after_create :send_admin_mail

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(email).deliver
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name
    user.image = auth.info.image
    # If you are using confirmable and the provider(s) you use validate emails,
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
    end
  end

  # https://rubydoc.info/github/plataformatec/devise/master/Devise/Models/Authenticatable
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : I18n.t("devise.registrations.signed_up_but_not_approved")
    # approved? ? super : :not_approved
  end

end
