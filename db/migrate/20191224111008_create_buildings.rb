class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings do |t|
      t.string 'name'
      t.string 'type'
      t.integer 'durability'
      t.integer 'cost'
      t.integer 'multiplicator'
      t.timestamps
    end
  end
end
