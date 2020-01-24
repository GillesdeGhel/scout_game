class Mining < ApplicationRecord
  belongs_to :patrol

  validates :man_power, numericality: true
  validates :patrol_id, presence: true
end
