class Product < ApplicationRecord
  include CodeGenerator

  belongs_to :product_list
  belongs_to :vendor
  belongs_to :user
end
