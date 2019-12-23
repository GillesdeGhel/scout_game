class Troop < ApplicationRecord
  has_one :city
  has_many :patrols
end
