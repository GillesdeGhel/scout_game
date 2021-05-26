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

  def constructable_fortifications
    return Building.fortifications.reject{ |b| b.name == 'Mur de bois' || b.name == 'Mur de pierre' } if stone_wall_complete?
    return Building.fortifications.reject{ |b| b.name == 'Mur de bois' || b.name == 'Muraille' } if wood_wall_complete?

    Building.fortifications.reject{ |b| b.name == 'Mur de pierre' || b.name == 'Muraille' }
  end

  def constructable_developments
    return Building.developments.reject{ |b| b.name == 'Chateau' || b.name == 'Forteresse' } if fortress_complete?
    return Building.developments.reject{ |b| b.name == 'Chateau' || b.name == 'Citadelle' } if castle_complete?

    Building.developments.reject{ |b| b.name == 'Forteresse' || b.name == 'Citadelle' }
  end

  def constructable_religious
    return Building.religious.reject{ |b| b.name == 'Chapelle' || b.name == 'Eglise' } if church_complete?
    return Building.religious.reject{ |b| b.name == 'Chapelle' || b.name == 'Cathédrale' } if chapel_complete?

    Building.religious.reject{ |b| b.name == 'Eglise' || b.name == 'Cathédrale' }
  end

  def fortification_complete?
    city.defense_building_multiplicator == (1 + Building.big_wall.multiplicator)
  end

  def religious_complete?
    city.tax_multiplicator == (1 + Building.find_by(name: 'Cathédrale').multiplicator)
  end

  def development_complete?
    city.passive_points_earning == (Building.find_by(name: 'Citadelle').multiplicator)
  end

  private

  def wood_wall_complete?
    city.defense_building_multiplicator == (1 + Building.wood_wall.multiplicator)
  end

  def stone_wall_complete?
    city.defense_building_multiplicator == (1 + Building.stone_wall.multiplicator)
  end

  def fortress_complete?
    city.passive_points_earning == Building.find_by(name: 'Forteresse').multiplicator
  end

  def castle_complete?
    city.passive_points_earning == Building.find_by(name: 'Chateau').multiplicator
  end

  def chapel_complete?
    city.tax_multiplicator == (1 + Building.find_by(name: 'Chapelle').multiplicator)
  end

  def church_complete?
    city.tax_multiplicator == (1 + Building.find_by(name: 'Eglise').multiplicator)
  end
end
