class Room < ApplicationRecord
  belongs_to :user
  has_many :user_rooms
  has_many :users, through: :user_rooms

  validates :name, presence: true
  validates :slots, presence: true
  validate :validate_slots_count

  before_validation :initialize_slots, on: :create

  def initialize_slots
    self.slots ||= []
  end

  def validate_slots_count
    errors.add(:slots, 'must be an array') unless slots.is_a?(Array)
    errors.add(:slots, 'must have at least one slot') if slots.length < 1
  end

  def available_slots
    (1..total_slots).to_a - slots
  end

  def take_slot(slot_number, user)
    return false unless available_slots.include?(slot_number)

    slots << slot_number
    users << user
    save
  end

  def total_slots
    # Define the total number of slots per room here
    16
  end
end
