class Patrol < ApplicationRecord
  belongs_to :troop
  has_many :constructions
  has_one :attack
  has_one :defense
  has_one :mining

  def attack_multiplicator
    return 1 unless constructions.any?

    attack_construction = constructions.select(&:attack?)
    attack_construction.sum { |construction| construction.building.multiplicator }
  end

  def city
    troop.city
  end

  def attack?
    attack.present?
  end

  def defense?
    defense.present?
  end

  def mining?
    mining.present?
  end

  def hold_paris?
    troop.hold_paris
  end

  def attack_power_on_paris
    return 0 unless attack&.city&.paris?

    attack.total_attack_power
  end
end
