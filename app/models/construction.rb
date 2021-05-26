class Construction < ApplicationRecord
  belongs_to :patrol
  belongs_to :building

  attr_accessor :city_id

  delegate :attack?, :defense?, :fortification?, :development?, :religious?, to: :building

  def self.temporaries
    Construction.select { |c| c.attack? || c.defense? }
  end
end
