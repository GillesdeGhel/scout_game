class TurnsController < ApplicationController
  def end_turn
    if current_user.admin?
      resolve_minings
      resolve_conflicts
      pay_patrols
      change_construction_durability
      destroy_all_actions
      compute_scores
      assign_guild
      assign_regional_capital
    else
      flash[:alert] = "T'es pas admin qu'est ce que tu fous"
    end
    redirect_to root_path
  end

  private

  def pay_patrols
    Patrol.all.each do |p|
      p.money += 100 * p.revenues_multiplicator
      p.money += 50 if p.hold_paris?
      p.money = 0 if p.money.negative?
      p.save!
    end
  end

  def resolve_minings
    Mining.all.each do |m|
      patrol = m.patrol
      patrol.money += m.man_power * 1.5 * patrol.mining_multiplicator
      patrol.save!
    end
  end

  def resolve_conflicts
    City.all.each do |c|
      if c.total_attack > c.total_defense
        if c.paris?
          capture_of_paris
        else
          pillage(c)
        end
        puts "#{c.name} a été pillée"
      else
        flash[:success] = "Paris a été défendue"
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

  def compute_scores
    Patrol.all.each do |p|
      p.total_gains += p.money
      p.save
    end
    if Troop.hold_paris.present?
      troop_with_paris = Troop.hold_paris
      troop_with_paris.turns_holding_paris += 1
      troop_with_paris.save
    end
  end

  def assign_guild
    Patrol.all.each do |p|
      p.guild = Guild.all.sample
      p.save
    end
  end

  def assign_regional_capital
    Patrol.update_all(hold_regional_capital: false)
    Troop.all.each do |t|
      best_patrol = t.patrols.sort_by(&:money).last
      best_patrol.update(hold_regional_capital: true)
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
    city.pillaged = true
    city.defense_building_multiplicator = city.defense_building_multiplicator / 2
    city.save
  end

  def capture_of_paris
    Troop.update_all(hold_paris: false)
    winning_troop = Troop.all.sort_by do |t|
      t.patrols.sum { |p| p.attack_power_on_paris }
    end.last
    winning_troop.hold_paris = true
    winning_troop.turns_holding_paris = 0 if winning_troop.turns_holding_paris.nil?
    winning_troop.save
    winning_troop.patrols.each do |p|
      p.money += 100
      p.total_gains += 500
    end
    flash[:alert] = "Paris a été prise par #{winning_troop.name}"
  end
end
