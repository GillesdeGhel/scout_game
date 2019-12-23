class City < ApplicationRecord
  belongs_to :troop
  has_many :attacks
end
