class Customer < ApplicationRecord
  validates :name, presence: true

  scope :available, ->(id) { where(online: true) && where(user_id: id) }
end
