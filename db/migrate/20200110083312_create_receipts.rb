class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.integer 'patrol_id'
      t.integer 'minings_winnings'
      t.integer 'attack_winnings'
      t.integer 'attacked_city_id'
      t.integer 'defense_losses'
      t.text 'attacking_patrols_ids', array: true, default: []
      t.integer 'base_revenues'
      t.timestamps
    end
  end
end
