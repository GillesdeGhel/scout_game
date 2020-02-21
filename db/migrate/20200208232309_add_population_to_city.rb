class AddPopulationToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :population, :integer, default: 0
  end
end
