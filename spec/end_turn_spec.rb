require 'spec_helper'
require 'rails_helper'


RSpec.describe TurnsController, type: :controller do
  describe 'GET end turn' do
    before do
      Rails.application.load_seed
      sign_in(User.find_by(email: 'admin@gmail.com'))
    end

    it 'end the turns 2 times' do
      Patrol.all.each do |p|
        Attack.create(man_power: rand(200), patrol: p, city: City.all.sample)
        Defense.create(man_power: rand(150), patrol: p, city: p.troop.city)
        Construction.create(building: Building.all.sample, patrol: p, durability: 2)
        Mining.create(man_power: rand(200), patrol: p)
      end
      controller.end_turn
      Patrol.all.each do |p|
        Attack.create(man_power: rand(200), patrol: p, city: City.all.sample)
        Defense.create(man_power: rand(150), patrol: p, city: p.troop.city)
        Construction.create(building: Building.all.sample, patrol: p, durability: 2)
        Mining.create(man_power: rand(200), patrol: p)
      end
      controller.end_turn
      expect(Attack.count).to eq 0
      expect(Defense.count).to eq 0
      expect(Mining.count).to eq 0
    end

    it 'the biggest attacker (with building mutlipliers) gets paris' do
      chamois = Patrol.find_by(name: 'Chamois')
      dauphin = Patrol.find_by(name: 'Dauphin')
      loutre = Patrol.find_by(name: 'Loutre')
      trebuchet = Building.find_by(name: 'Trébuchet')
      Attack.create(man_power: 200, patrol: chamois, city: City.paris)
      Attack.create(man_power: 200, patrol: dauphin, city: City.paris)
      Construction.create(building: trebuchet, durability: trebuchet.durability, patrol: dauphin)
      Attack.create(man_power: 300, patrol: loutre, city: City.paris)

      controller.end_turn

      expect(Attack.count).to eq 0
      expect(Defense.count).to eq 0
      expect(Mining.count).to eq 0
      dauphin.reload
      chamois.reload
      expect(dauphin.hold_paris?).to eq true
      expect(dauphin.money > chamois.money).to eq true
      expect(dauphin.total_gains > chamois.total_gains).to eq true
    end
  end
end
