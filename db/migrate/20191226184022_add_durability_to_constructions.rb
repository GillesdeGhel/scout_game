class AddDurabilityToConstructions < ActiveRecord::Migration[5.2]
  def change
    add_column :constructions, :durability, :integer
  end
end
