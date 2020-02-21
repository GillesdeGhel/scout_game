class AddFortificationLevelToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :fortification_level, :integer, default: 0
  end
end
