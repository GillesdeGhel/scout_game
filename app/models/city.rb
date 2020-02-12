class City < ApplicationRecord
  belongs_to :troop
  has_many :attacks
  has_many :defenses

  def total_attack
    attacks.sum(&:total_attack_power)
  end

  def total_defense
    defenses.sum(&:total_defense_power)
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
