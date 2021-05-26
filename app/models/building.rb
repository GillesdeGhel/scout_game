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
    Building.where(usage: 'defense')
  end

  def self.attacks
    Building.where(usage: 'attack')
  end

  def self.fortifications
    Building.where(usage: 'fortification')
  end

  def self.developments
    Building.where(usage: 'development')
  end

  def self.religious
    Building.where(usage: 'religious')
  end

  def attack?
    usage.eql?('attack')
  end

  def defense?
    usage.eql?('defense')
  end

  def religious?
    usage.eql?('religious')
  end

  def development?
    usage.eql?('development')
  end

  def fortification?
    usage.eql?('fortification')
  end
end
