class AddPillageToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :pillaged, :boolean, default: false
  end
end
