class Construction < ApplicationRecord
  belongs_to :patrol
  belongs_to :building

  attr_accessor :city_id

  def attack?
    building.usage.eql?('attack')
  end

  def defense?
    building.usage.eql?('defense')
  end

  def fortification?
    building.usage.eql?('fortification')
  end
end
