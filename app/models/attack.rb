class Attack < ApplicationRecord
  belongs_to :patrol
  belongs_to :city

  validates :man_power, numericality: true
  validates :city_id, presence: true
  validates :patrol_id, presence: true

  def total_attack_power
    (man_power * patrol.attack_multiplicator).round(2)
  end
end
