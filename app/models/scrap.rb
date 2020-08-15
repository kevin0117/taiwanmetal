class Scrap < ApplicationRecord
  include CodeGenerator
  paginates_per 10

  belongs_to :customer
  belongs_to :user

  has_many :refine_lists
  has_many :refine_orders, through: :refine_lists

  validates :title, :gross_weight, :wastage_rate, :gold_buying, presence: true

  scope :available, -> { where(in_stock: true) }

end
