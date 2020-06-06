class Customer < ApplicationRecord
  validates :name, presence: true

  scope :available, -> { where(online: true) }
end
