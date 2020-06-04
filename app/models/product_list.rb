class ProductList < ApplicationRecord
  validates :name, presence: true
end
