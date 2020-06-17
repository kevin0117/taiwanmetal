class Product < ApplicationRecord
  include CodeGenerator
  has_rich_text :description

  belongs_to :price_board
  belongs_to :product_list
  belongs_to :vendor
  belongs_to :user

  validates :title, :weight, :cost, :service_fee, presence: true
  validates :service_fee, :cost, numericality: { greater_than_or_equal_to: 0, allow_nil: true}
  validates :code, uniqueness: true
  
end
