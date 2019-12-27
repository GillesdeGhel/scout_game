class CreateGuilds < ActiveRecord::Migration[5.2]
  def change
    create_table :guilds do |t|
      t.string 'name'
      t.float 'attack_power_multiplicator', default: 1
      t.float 'defense_power_multiplicator', default: 1
      t.float 'attack_construction_cost_multiplicator', default: 1
      t.float 'defense_construction_cost_multiplicator', default: 1
      t.float 'mining_multiplicator', default: 1
      t.float 'revenues_multiplicator', default: 1
      t.timestamps
    end
  end
end
