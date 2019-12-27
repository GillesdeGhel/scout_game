class Troop < ApplicationRecord
  has_one :city
  has_many :patrols

  def self.hold_paris
    Troop.find_by(hold_paris: true)
  end
end
