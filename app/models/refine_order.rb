class RefineOrder < ApplicationRecord
  belongs_to :scrap
  belongs_to :user

  has_many :refine_lists, dependent: :destroy
  has_many :scraps, through: :refine_lists

  enum status: { pending: 0, confirm: 1, delivered: 2 }

end