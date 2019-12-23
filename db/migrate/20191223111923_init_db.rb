class InitDb < ActiveRecord::Migration[5.0]
  def change
    create_table 'troops', force: :cascade do |t|
      t.string   'name'
      t.integer  'turns_holding_paris'
      t.boolean  'hold_paris'
    end

    create_table 'patrols', force: :cascade do |t|
      t.string   'name'
      t.integer  'troop_id'
      t.integer  'money'
      t.boolean  'hold_regional_capital'
      t.integer  'total_gains'
    end

    create_table 'cities', force: :cascade do |t|
      t.string   'name'
      t.integer  'troop_id'
      t.integer  'defense_men_power'
      t.integer  'defense_building_multiplicator'
    end
  end
end
