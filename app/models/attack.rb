class Attack < ApplicationRecord
  belongs_to :patrol
  belongs_to :city
end
