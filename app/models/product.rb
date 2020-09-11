class Product < ApplicationRecord
  include CodeGenerator
  has_one_attached :barcode
  has_rich_text :description
  paginates_per 10

  belongs_to :price_board
  belongs_to :product_list
  belongs_to :vendor
  belongs_to :user

  validates :title, :weight, :cost, :service_fee, presence: true
  validates :service_fee, :cost, numericality: { greater_than_or_equal_to: 0, allow_nil: true}
  validates :code, uniqueness: true

  has_many :manifests
  has_many :sales, through: :manifests
  
  scope :available, -> { where(on_sell: true) }
end
