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
    return '∞' if fortification_level >= 30
    return 30 if fortification_level >= 20
    return 20 if fortification_level >= 10

    10
  end

  def development_label
    return 'Citadelle (3 points par tour)' if development_level >= 30
    return 'Forteresse (2 points par tour)' if development_level >= 20
    return 'Chateau (1 points par tour)' if development_level >= 10

    'Pas encore de dévelopement urbain'
  end

  def development_next_level
    return '∞' if development_level >= 30
    return 30 if development_level >= 20
    return 20 if development_level >= 10

    10
  end

  def religious_label
    return 'Cathédrale (+ 60% de taxes)' if religious_level >= 30
    return 'Eglise (+ 40% de taxes)' if religious_level >= 20
    return 'Chapelle (+ 20% de taxes)' if religious_level >= 10

    'Pas encore de lieu saint'
  end

  def religious_next_level
    return '∞' if religious_level >= 30
    return 30 if religious_level >= 20
    return 20 if religious_level >= 10

    10
  end
end
