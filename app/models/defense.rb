class Defense < ApplicationRecord
  belongs_to :patrol
  belongs_to :city

  def total_defense_power
    multiplicator = city.defense_building_multiplicator + patrol.defense_power_multiplicator
    man_power * (multiplicator.positive? ? multiplicator : 1)
  end
end
