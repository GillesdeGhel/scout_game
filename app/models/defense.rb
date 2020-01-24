class Defense < ApplicationRecord
  belongs_to :patrol
  belongs_to :city

  validates :man_power, numericality: true
  validates :city_id, presence: true
  validates :patrol_id, presence: true

  def total_defense_power
    multiplicator = city.defense_building_multiplicator * patrol.defense_power_multiplicator
    (man_power * multiplicator).round(2)
  end
end
