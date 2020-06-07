class Scrap < ApplicationRecord
  include CodeGenerator

  belongs_to :customer
  belongs_to :user

  validates :title, :gross_weight, :wastage_rate, :gold_buying, presence: true
end
