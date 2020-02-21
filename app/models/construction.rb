class Construction < ApplicationRecord
  belongs_to :patrol
  belongs_to :building

  attr_accessor :city_id

  delegate :attack?, :defense?, :fortification?, to: :building
end
