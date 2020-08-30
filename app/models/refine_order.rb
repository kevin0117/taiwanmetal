class RefineOrder < ApplicationRecord
  belongs_to :scrap
  belongs_to :user
  include AASM

  has_many :refine_lists, dependent: :destroy
  has_many :scraps, through: :refine_lists

  enum status: { pending: 0, scheduled: 1, confirmed:2, closed: 3 }

  aasm column: 'state' do
    state :pending, initial: true
    state :scheduled, :confirmed, :closed

    event :notify do
      transitions from: :pending, to: :scheduled
    end

    event :reply do
      transitions from: :scheduled, to: :confirmed
    end

    event :refine do
      transitions from: :confirmed, to: :closed
    end
  end

end 