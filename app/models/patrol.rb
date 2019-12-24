class Patrol < ApplicationRecord
  belongs_to :troop
  has_many :constructions
  has_one :attack
  has_one :defense
  has_one :mining
end
