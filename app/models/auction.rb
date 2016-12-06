class Auction < ApplicationRecord
  belongs_to :user

  has_many :bids, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :ends_on, presence: true
  validates :reserve_price, presence: true

  include AASM

  aasm do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met

    event :publish do
      transitions from: :draft, to: :published
    end

    event :met do
      transitions from: :published, to: :reserve_met
    end

    event :not_met do
      transitions from: :published, to: :reserve_not_met
    end

    event :win do
      transitions from: [:published, :reserve_met], to: :won
    end

    event :cancel do
      transitions from: [:draft, :published, :won, :reserve_met, :reserve_not_met], to: :canceled
    end

    event :draft do
      transitions from: [:canceled, :published], to: :draft
    end
  end

end
