class TurnsController < ApplicationController
  def end_turn
    pay_patrols
    resolve_minings
    resolve_conflicts
    change_construction_durability
    destroy_all_actions

    redirect_to root_path
  end

  private

  def pay_patrols
    Patrol.all.each do |p|
      p.money += 100
      p.save!
    end
  end

  def resolve_minings
    Mining.all.each do |m|
      m.patrol.money += m.man_power * 1.5
      m.patrol.save!
    end
  end

  def resolve_conflicts
    City.all.each do |c|
      if c.total_attack > c.total_defense
        if c.name.eql?('Paris')
          capture_of_paris
        else
          pillage(c)
        end
        puts "#{c.name} a été pillée"
      else
        puts "#{c.name} a été défendue"
      end
    end
  end

  def destroy_all_actions
    Mining.destroy_all
    Attack.destroy_all
    Defense.destroy_all
  end

  def change_construction_durability
    Construction.all.select(&:attack?).each do |c|
      if c.durability.eql?(1)
        c.destroy
        next
      else
        c.durability -= 1
        c.save
      end
    end
  end

  def pillage(city)
    city.troop.patrols.each do |patrol|
      if city.defense_manpower.zero?
        patrol.money -= (city.power_difference / 6)
        patrol.save!
        next
      else
        patrol_man_power = patrol.defense&.man_power || 0
        patrol_percentage = 1 - (patrol_man_power / city.defense_manpower)
        patrol.money -= city.power_difference * patrol_percentage * 2
        patrol.save!
      end
    end
    city.attacks.each do |a|
      percentage = a.total_attack_power / city.total_attack
      a.patrol.money += city.power_difference * percentage * 2
      a.patrol.save!
    end
    city.defense_building_multiplicator = 0
    city.save
  end

  def capture_of_paris

  end


  # def capture_of_paris
  #   attacks_on_the_city('Paris').
  # end
end
