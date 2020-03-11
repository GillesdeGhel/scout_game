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

  def fortification_label
    return 'Muraille (+ 300%)' if fortification_level >= 30
    return 'Mur de Pierre (+ 200%)' if fortification_level >= 20
    return 'Mur de bois (+100%)' if fortification_level >= 10

    'Pas encore de mur'
  end 

  def fortification_next_level
    return 20 if fortification_level >= 10
    return 30 if fortification_level >= 20
    return '∞' if fortification_level >= 30

    10
  end 
end
