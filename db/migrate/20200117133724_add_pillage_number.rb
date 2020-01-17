class AddPillageNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :pillage_count, :integer, default: 0
  end
end
