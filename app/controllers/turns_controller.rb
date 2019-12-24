class TurnsController < ApplicationController
  def end_turn
    Patrol.all.each do |p|
      p.money += 100
      p.save!
    end
    City.all.each do |c|
      if total_attack(c) > total_defense(c)
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
    Attack.destroy_all
    Defense.destroy_all
    redirect_to root_path
  end

  private

  def total_attack(city)
    attacks_on_the_city(city).sum do |a|
      attack_power(a)
    end
  end

  def attacks_on_the_city(city)
    Attack.select { |a| a.city.eql?(city) }
  end

  def attack_power(attack)
    constructions = attack.patrol.constructions.select { |construction| construction.type.eql?('attack') }
    construction_multiplicator = constructions.sum(&:multiplicator)
    attack.man_power * (construction_multiplicator.positive? ? construction_multiplicator : 1)
  end

  def defense_manpower(city)
    defenses_on_the_city = Defense.select { |d| d.city.eql?(city) }
    defenses_on_the_city.sum(&:man_power)
  end

  def total_defense(city)
    defense_manpower(city) * (city.defense_building_multiplicator.positive? ? city.defense_building_multiplicator : 1)
  end

  def pillage(city)
    binding.pry
    city.troop.patrols.each do |patrol|
      if defense_manpower(city).zero?
        patrol.money -= (power_difference(city) / 6)
        patrol.save!
        next
      else
        patrol_man_power = p.defense&.man_power || 0
        patrol_percentage = 1 - (patrol_man_power / defense_manpower(city))
        patrol.money -= power_difference(city) * patrol_percentage
        patrol.save!
      end
    end
    attacks_on_the_city(city).each do |a|
      percentage = attack_power(a) / total_attack(city)
      a.patrol.money += power_difference(city) * percentage
      a.patrol.save!
    end
  end

  def power_difference(city)
    total_attack(city) - total_defense(city)
  end

  # def capture_of_paris
  #   attacks_on_the_city('Paris').
  # end
end
