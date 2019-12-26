class Construction < ApplicationRecord
  belongs_to :patrol
  belongs_to :building

  def attack?
    building.usage.eql?('attack')
  end
end
