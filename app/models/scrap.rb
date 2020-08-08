class Scrap < ApplicationRecord
  include CodeGenerator
  paginates_per 10

  belongs_to :customer
  belongs_to :user

  validates :title, :gross_weight, :wastage_rate, :gold_buying, presence: true
end
