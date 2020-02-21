class Defense < ApplicationRecord
  belongs_to :patrol
  belongs_to :city

  validates :man_power, numericality: true
  validates :city_id, presence: true
  validates :patrol_id, presence: true

  def total_defense_power
    (man_power * multiplicator).round(2)
  end

  def multiplicator
    (patrol.defense_multiplicator * city.defense_building_multiplicator).round(2)
  end
end
