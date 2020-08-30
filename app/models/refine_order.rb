class RefineOrder < ApplicationRecord
  belongs_to :scrap
  belongs_to :user
  include AASM

  has_many :refine_lists, dependent: :destroy
  has_many :scraps, through: :refine_lists

  validates :request_date, :recipient, presence: true

  enum status: { awaiting: 0, scheduled: 1, confirmed:2, closed: 3 }

  aasm column: 'state' do
    state :pending, initial: true
    state :scheduling, :confirming, :closing

    event :notify do
      transitions from: :pending, to: :scheduling
    end

    event :reply do
      transitions from: :scheduling, to: :confirming
    end

    event :refine do
      transitions from: :confirming, to: :closing
    end
  end

end 