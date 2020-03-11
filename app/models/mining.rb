class Mining < ApplicationRecord
  belongs_to :patrol

  validates :man_power, numericality: true
  validates :patrol_id, presence: true

  def total_revenues
    man_power * 1.1 * patrol.mining_multiplicator
  end
end
