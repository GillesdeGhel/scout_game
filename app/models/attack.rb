class Attack < ApplicationRecord
  belongs_to :patrol
  belongs_to :city

  def total_attack_power
    man_power * patrol.attack_multiplicator
  end
end
