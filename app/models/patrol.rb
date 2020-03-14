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
    return attack_power_multiplicator unless constructions.any?

    attack_constructions = constructions.select(&:attack?)
    (1 + attack_constructions.sum { |construction| construction.building.multiplicator }) * attack_power_multiplicator
  end

  def defense_multiplicator
    return (defense_power_multiplicator).round(2) unless constructions.any?

    defense_constructions = constructions.select(&:defense?)
    ((1 + defense_constructions.sum { |construction| construction.building.multiplicator }) * defense_power_multiplicator).round(2)
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

  def constructable_buildings
    return Building.all.reject{ |b| b.fortification? } if fortification_complete?
    return Building.all.reject{ |b| b.name == 'Mur de bois' || b.name == 'Mur de pierre' } if stone_wall_complete?
    return Building.all.reject{ |b| b.name == 'Mur de bois' || b.name == 'Muraille' } if wood_wall_complete?

    Building.all.reject{ |b| b.name == 'Mur de pierre' || b.name == 'Muraille' }
  end 
  
  private

  def wood_wall_complete?
    city.defense_building_multiplicator == (1 + Building.wood_wall.multiplicator)
  end

  def stone_wall_complete?
    city.defense_building_multiplicator == (1 + Building.stone_wall.multiplicator)
  end

  def fortification_complete?
    city.defense_building_multiplicator == (1 + Building.big_wall.multiplicator)
  end
end