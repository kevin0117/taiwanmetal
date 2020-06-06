class Scrap < ApplicationRecord
  include CodeGenerator

  belongs_to :customer
  belongs_to :user
end
