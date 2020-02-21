class AddCityReceipts < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :previous_total_attack, :integer, default: 0
    add_column :cities, :previous_total_defense, :integer, default: 0
  end
end
