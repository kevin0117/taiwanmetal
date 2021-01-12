class Scrap < ApplicationRecord
  include CodeGenerator
  paginates_per 10

  belongs_to :customer
  belongs_to :user

  has_many :refine_lists
  has_many :refine_orders, through: :refine_lists

  validates :title, :net_weight, :gross_weight, :wastage_rate, :gold_buying, presence: true
  validates :total_price, :net_weight, :gross_weight, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  scope :available, -> { where(in_stock: true) }
end
