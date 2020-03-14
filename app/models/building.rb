class Building < ApplicationRecord
  has_many :constructions

  def self.wood_wall
    Building.find_by(name: 'Mur de bois')
  end

  def self.stone_wall
    Building.find_by(name: 'Mur de pierre')
  end

  def self.big_wall
    Building.find_by(name: 'Muraille')
  end

  def self.defenses
    Building.select { |b| b.usage.eql?('defense') }
  end

  def self.attacks
    Building.select { |b| b.usage.eql?('attack') }
  end

  def self.fortifications
    Building.select { |b| b.usage.eql?('fortification') }
  end

  def attack?
    usage.eql?('attack')
  end

  def defense?
    usage.eql?('defense')
  end

  def fortification?
    usage.eql?('fortification')
  end
end
