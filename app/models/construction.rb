class Construction < ApplicationRecord
  belongs_to :patrol
  belongs_to :building

  attr_accessor :city_id

  def attack?
    building.usage.eql?('attack')
  end
end
