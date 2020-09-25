class RefineOrder < ApplicationRecord
  belongs_to :scrap
  belongs_to :user
  include AASM

  has_many :refine_lists, dependent: :destroy
  has_many :scraps, through: :refine_lists

  validates :request_date, :recipient, presence: true

  aasm column: 'status' do
    state :pending, initial: true
    state :scheduling, :refining, :closing

    event :notify do
      transitions from: :pending, to: :scheduling
    end

    event :cancel do
      transitions from: :pending, to: :closing
    end

    event :reply do
      transitions from: :scheduling, to: :refining
    end

    event :report do
      transitions from: :refining, to: :closing
    end
  end

end 