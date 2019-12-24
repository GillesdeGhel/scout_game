class CreateConstructions < ActiveRecord::Migration[5.2]
  def change
    create_table :constructions do |t|
      t.integer 'patrol_id'
      t.integer 'building_id'
      t.timestamps
    end
  end
end
