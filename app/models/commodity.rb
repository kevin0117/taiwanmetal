class Commodity < ApplicationRecord
  belongs_to :user
  acts_as_paranoid
  include AASM

  enum action: { Buy: 0, Sell: 1}
  scope :available, -> { where(status: 'open') }
  scope :closed, ->(id) { (where(user_id: id).or(where(closer_id: id))).where(status: 'closed') }

  aasm column: 'status' do
    state :open, initial: true
    state :closed, :cancelled
  
    event :cancel do
      
      transitions from: :open, to: :cancelled
    end

    event :trade do

      transitions from: :open, to: :closed
    end
  end
end
