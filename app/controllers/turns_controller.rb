class TurnsController < ApplicationController
  require 'events'

  EVENTS = %w[
    city_plague
    campaign_plague
    fund_raising
    earthquake
    fiscal_fraud
    successfull_trade
    clemency
    gas_blast
    barbarism
  ].freeze

  private_constant :EVENTS

  def end_turn
    if current_user.admin?
      reset_all_receipts
      randomize_event
      resolve_minings
      resolve_conflicts
      # pay_patrols
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

  attr_reader :event

  def reset_all_receipts
    Receipt.destroy_all
    patrols.each { |p| Receipt.create(patrol_id: p.id) }
  end

  def randomize_event
    return if rand(2) == 1

    @event = EVENTS.sample
    Event.send(event)
    flash[:info] = "Attention, il y a eu un événement aléatoire"
  end

  def resolve_minings
    return if event.eql?('gas_blast')

    Mining.all.each do |m|
      patrol = m.patrol
      revenues = m.man_power * 1.5 * patrol.mining_multiplicator
      patrol.money += revenues
      patrol.receipt.minings_winnings += revenues
      patrol.receipt.save!
      patrol.save!
    end
  end

  def resolve_conflicts
    City.all.each do |c|
      c.pillaged = false
      if c.total_attack > c.total_defense
        if c.paris?
          capture_of_paris
        else
          pillage(c)
        end
        puts "#{c.name} a été pillée"
      end
      c.save!
    end
  end

  # def pay_patrols
  #   return if event.eql?('fiscal_fraud')
  #
  #   patrols.each do |p|
  #     revenues = 100 * p.revenues_multiplicator
  #     revenues = revenues * 1.3 if event.eql?('successfull_trade')
  #     p.money += revenues
  #     if p.hold_paris?
  #       p.money += 50
  #       p.receipt.paris_winning += 50
  #     end
  #     p.money = 0 if p.money.negative?
  #     p.receipt.base_revenues += revenues
  #     p.receipt.save!
  #     p.save!
  #   end
  # end

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
    patrols.each do |p|
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
    patrols.each do |p|
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
      if city.defense_man_power.zero?
        revenues = (city.power_difference / 6)
        patrol.money -= revenues
        patrol.receipt.defense_losses -= revenues
        patrol.receipt.save!
        patrol.save!
        next
      else
        patrol_percentage = inverse_of_defense_patrol_man_power_ratio(patrol) / defense_fraction(city)
        revenues = city.power_difference * patrol_percentage * 1.5
        revenues * 0.6 if event.eql?('clemency')
        patrol.money -= revenues
        patrol.receipt.defense_losses -= revenues
        patrol.receipt.save!
        patrol.save!
      end
    end
    city.attacks.each do |a|
      percentage = a.total_attack_power / city.total_attack
      revenues = city.power_difference * percentage * 1.5
      revenues * 1.5 if event.eql?('barbarism')
      a.patrol.money += revenues
      a.patrol.receipt.attack_winnings += revenues
      a.patrol.receipt.save!
      a.patrol.save!
    end
    city.pillaged = true
    city.pillage_count += 1
    city.defense_building_multiplicator = (city.defense_building_multiplicator / 2).round(2)
  end

  def capture_of_paris
    Troop.update_all(hold_paris: false)
    winning_troop = Troop.all.sort_by do |t|
      t.patrols.sum { |p| p.attack_power_on_paris }
    end.last
    winning_troop.hold_paris = true
    winning_troop.turns_holding_paris = 0 if winning_troop.turns_holding_paris.nil?
    winning_troop.save!
    winning_troop.patrols.each do |p|
      revenues = 100
      p.money += revenues
      p.total_gains += 500
      p.receipt.paris_winning += revenues
      p.receipt.save!
      p.save!
    end
    paris = City.paris
    paris.pillaged = true
    paris.defense_building_multiplicator = (paris.defense_building_multiplicator / 2).round(2)
    paris.save
    flash[:alert] = "Paris a été prise par #{winning_troop.name}"
  end

  def patrols
    @patrols = Patrol.all
  end

  def inverse_of_defense_patrol_man_power_ratio(patrol)
    patrol_man_power = patrol.defense&.man_power || 1
    1 / (patrol_man_power.to_f / patrol.city.defense_man_power.to_f)
  end

  def defense_fraction(city)
    city.troop.patrols.sum do |patrol|
      inverse_of_defense_patrol_man_power_ratio(patrol)
    end
  end
end
