class Defense < ApplicationRecord
  belongs_to :patrol
  belongs_to :city

  def total_defense_power
    construction_multiplicator = city.defense_building_multiplicator
    man_power * (construction_multiplicator.positive? ? construction_multiplicator : 1)
  end
end
