class ChangeDefenseMultiplicatorToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :cities, :defense_building_multiplicator, :float
  end
end
