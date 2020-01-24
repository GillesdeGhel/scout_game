class Patrol < ApplicationRecord
  belongs_to :troop
  belongs_to :guild
  has_many :constructions
  has_one :attack
  has_one :defense
  has_one :mining
  has_one :receipt

  delegate :attack_power_multiplicator, :defense_power_multiplicator,
  :attack_construction_cost_multiplicator, :defense_construction_cost_multiplicator,
  :mining_multiplicator, :revenues_multiplicator, to: :guild

  delegate :city, to: :troop

  def attack_multiplicator
    return 1 unless constructions.any?

    attack_construction = constructions.select(&:attack?)
    attack_construction.sum { |construction| construction.building.multiplicator } * attack_power_multiplicator
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

  def ranking
    Patrol.count { |p| p.total_gains > self.total_gains } + 1
  end
end
