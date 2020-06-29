class Vendor < ApplicationRecord
  validates :name, presence: true

  belongs_to :user

  scope :available, ->(id) { where(online: true) && where(user_id: id) }
end
