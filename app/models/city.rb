class City < ApplicationRecord
  belongs_to :troop
  has_many :attacks
  has_many :defenses

  def total_attack
    attacks.sum(&:total_attack_power)
  end

  def defense_man_power
    defenses.sum(&:man_power)
  end

  def total_defense
    defense_man_power * (defense_building_multiplicator > 1 ? defense_building_multiplicator : 1)
  end

  def power_difference
    total_attack - total_defense
  end

  def paris?
    name.eql?('Paris')
  end

  def self.paris
    City.find_by(name: 'Paris')
  end

  def label
    return "#{self.name} (#{Troop.hold_paris&.name})" if self.paris?
    "#{self.name} - #{self.troop&.country_name} (#{self.troop&.name})"
  end
end
