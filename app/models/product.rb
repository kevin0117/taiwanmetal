class Product < ApplicationRecord
  belongs_to :product_list
  belongs_to :vendor
  belongs_to :user
end
