class City < ApplicationRecord
  belongs_to :troop
  has_many :attacks
  has_many :defenses

  def total_attack
    attacks.sum(&:total_attack_power)
  end

  def defense_manpower
    defenses.sum(&:man_power)
  end

  def total_defense
    defense_manpower * (defense_building_multiplicator.positive? ? defense_building_multiplicator : 1)
  end

  def power_difference
    total_attack - total_defense
  end
end
