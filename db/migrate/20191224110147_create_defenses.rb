class CreateDefenses < ActiveRecord::Migration[5.2]
  def change
    create_table :defenses do |t|
      t.integer 'patrol_id'
      t.integer 'city_id'
      t.integer 'man_power'
      t.timestamps
    end
  end
end
