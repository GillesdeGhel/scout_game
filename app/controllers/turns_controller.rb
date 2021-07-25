class TurnsController < ApplicationController
  before_action :authenticate_user!

  require 'events'

  EVENTS = [
    # {
    #   value: 'city_plague',
    #   label: 'Peste dans les villes: -30% hommes en défense'
    # },
    # {
    #   value: 'campaign_plague',
    #   label: 'Peste dans les campements: -30% hommes en attaque'
    # },
    # {
    #   value: 'fund_raising',
    #   label: 'Levée de fond, +200 or'
    # },
    {
      value: 'earthquake',
      label: 'Tremblement de terre: bâtiments défensifs détruits'
    },
    # {
    #   value: 'fiscal_fraud',
    #   label: 'Fraude fiscale: revenus des taxes diminués de moitié'
    # },
    # {
    #   value: 'successfull_trade',
    #   label: 'Commerce fructueux: +30% de revenus des taxes'
    # },
    {
      value: 'clemency',
      label: 'Clémence et miséricorde: -30% de pertes suite aux pillages de villes'
    },
    {
      value: 'gas_blast',
      label: 'Coup de grisou: revenus miniers diminués de moitié'
    },
    {
      value: 'barbarism',
      label: 'Barbarisme invétéré: +30% des revenus suite aux pillages de villes'
    }
  ].freeze

  private_constant :EVENTS

  def end_turn
    if current_user.admin?
      reset_all_receipts
      randomize_event
      resolve_minings
      resolve_conflicts
      pay_patrols
      increase_population
      change_construction_durability
      add_power_in_receipts
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
    # return if rand(2) == 1

    @event = EVENTS.sample
    Event.send(event[:value])
    flash[:info] = "Evénement: #{event[:label]}"
  end

  def resolve_minings
    Mining.all.includes(:patrol).each do |m|
      revenues = m.total_revenues
      revenues *= 0.5 if event&.[](:value).eql?('gas_blast')
      patrol = m.patrol
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
      end
      c.save!
    end
  end

  def pay_patrols
    patrols.each do |p|
      p.money = 0 if p.money.negative?
      revenues = p.city.population * (p.revenues_multiplicator + p.city.tax_multiplicator) * 0.2
      revenues *= 1.3 if event&.[](:value).eql?('successfull_trade')
      revenues *= 0.5 if event&.[](:value).eql?('fiscal_fraud')
      p.money += revenues
      if p.hold_paris?
        p.money += 100
        p.receipt.paris_winning += 100
      end
      p.receipt.base_revenues = revenues
      p.receipt.save!
      p.save!
    end
  end

  def increase_population
    City.all.each do |c|
      c.population += 1000
      c.save
    end
  end

  def destroy_all_actions
    Mining.destroy_all
    Attack.destroy_all
    Defense.destroy_all
  end

  def change_construction_durability
    Construction.temporaries.each do |c|
      if c.durability.eql?(1)
        c.destroy
        next
      else
        c.durability -= 1
        c.save
      end
    end
  end

  def add_power_in_receipts
    City.all.each do |c|
      c.previous_total_attack = c.total_attack
      c.previous_total_defense = c.total_defense
      c.save!
    end
  end

  def compute_scores
    patrols.each do |p|
      p.total_gains += p.money
      p.save
    end
    Troop.all.each do |t|
      t.turns_holding_paris += t.city.passive_points_earning
      t.turns_holding_paris += 5 if t.hold_paris?
      t.save
    end
  end

  def assign_guild
    troops.each do |t|
      array = Guild.all.map(&:id)
      t.patrols.each do |p|
        p.guild_changed = false
        sample = array.sample
        p.guild_id = sample
        array.delete(sample)
        p.save
      end
    end
  end

  def assign_regional_capital
    Patrol.update_all(hold_regional_capital: false)
    troops.each do |t|
      best_patrol = t.patrols.max_by(&:money)
      best_patrol.update(hold_regional_capital: true)
    end
  end

  def pillage(city)
    city.troop.patrols.includes(:receipt).each do |patrol|
      # if city.total_defense.zero?
      losses = (city.population / 6)
      losses * 0.7 if event&.[](:value).eql?('clemency')
      patrol.money -= losses
      patrol.receipt.defense_losses = losses
      patrol.receipt.save!
      patrol.save!
      # next
      # else
      #   patrol_percentage = inverse_of_defense_patrol_man_power_ratio(patrol) / defense_fraction(city)
      #   revenues = city.population * patrol_percentage
      #   revenues * 0.7 if event&.[](:value).eql?('clemency')
      #   patrol.money -= revenues
      #   patrol.receipt.defense_losses = revenues
      #   patrol.receipt.save!
      #   patrol.save!
      # end
    end
    attack_counter = 0
    city.attacks.includes(:patrol).select { |a| a.total_attack_power.positive? }.sort_by(&:total_attack_power).each do |a|
      attack_counter += 1
      attack_count = city.attacks.count
      percentage = (attack_counter.to_f / (1..attack_count).sum.to_f)
      revenues = city.population * percentage
      revenues * 1.3 if event&.[](:value).eql?('barbarism')
      attack_points_earned = (city.population * percentage / 1000).round
      a.patrol.money += revenues
      a.patrol.receipt.attack_winnings = revenues
      a.patrol.receipt.attack_points_earned = attack_points_earned
      a.patrol.receipt.save!
      a.patrol.save!
      a.patrol.troop.turns_holding_paris += attack_points_earned
      a.patrol.troop.save!
    end
    city.pillaged = true
    city.pillage_count += 1
    city.troop.turns_holding_paris -= 1
    city.troop.save!
    city.population = (city.population / 2).round(2)
  end

  def capture_of_paris
    Troop.update_all(hold_paris: false)
    winning_troop = troops.max_by do |t|
      t.patrols.sum(&:attack_power_on_paris)
    end
    winning_troop.hold_paris = true
    winning_troop.turns_holding_paris = 0 if winning_troop.turns_holding_paris.nil?
    winning_troop.save!
    winning_troop.patrols.each do |p|
      revenues = 200
      p.money += revenues
      p.receipt.paris_winning += revenues
      p.receipt.save!
      p.save!
    end
    paris = City.paris
    paris.pillaged = true
    paris.defense_building_multiplicator = 1
    paris.save
    flash[:alert] = "Paris a été prise par #{winning_troop.name}"
  end

  def patrols
    Patrol.all.includes(:receipt, troop: :city)
  end

  def troops
    Troop.all.includes(:patrols)
  end

  # def inverse_of_defense_patrol_man_power_ratio(patrol)
  #   patrol_man_power = (patrol.defense&.city == patrol.city && patrol.defense&.man_power.present?) ? patrol.defense.man_power.positive? ? patrol.defense.man_power : 1 : 1
  #   1 / (patrol_man_power.to_f / patrol.city.total_defense.to_f)
  # end

  # def defense_fraction(city)
  #   city.troop.patrols.sum do |patrol|
  #     inverse_of_defense_patrol_man_power_ratio(patrol)
  #   end
  # end
end
