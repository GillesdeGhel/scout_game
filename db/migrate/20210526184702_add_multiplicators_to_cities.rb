class AddMultiplicatorsToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :tax_multiplicator, :float, default: 0
    add_column :cities, :passive_points_earning, :integer, default: 0
    add_column :cities, :development_level, :integer, default: 0
    add_column :cities, :religious_level, :integer, default: 0
  end
end
