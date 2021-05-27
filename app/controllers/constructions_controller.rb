class ConstructionsController < ApplicationController
  def create
    construction = Construction.new(construction_params)
    cost_multiplicator = %w[fortification development religious].include?(building.usage) ? patrol.defense_construction_cost_multiplicator : patrol.attack_construction_cost_multiplicator
    cost = building.cost * cost_multiplicator
    if cost <= patrol.money && construction.save
      construction.update!(durability: building.durability)
      patrol.money -= cost
      if building.usage.eql?('fortification')
        city.fortification_level += 1
        if (city.fortification_level % 10).zero?
          city.defense_building_multiplicator = 1 + building.multiplicator
        end
        city.save!
      end
      if building.usage.eql?('religious')
        city.religious_level += 1
        if (city.religious_level % 10).zero?
          city.tax_multiplicator = building.multiplicator
        end
        city.save!
      end
      if building.usage.eql?('development')
        city.development_level += 1
        if (city.development_level % 10).zero?
          city.passive_points_earning = building.multiplicator
        end
        city.save!
      end
      patrol.save!
      flash[:success] = "Les hommes ont construit #{building.name} "
    else
      flash[:alert] = 'Pas assez de thune'
    end
    redirect_to patrol_path(patrol.id)
  end

  def index
    @constructions = Construction.all
  end

  def patrol
    @patrol ||= Patrol.find(construction_params[:patrol_id])
  end

  def building
    @building ||= Building.find(construction_params[:building_id])
  end

  def city
    @city ||= City.find(construction_params[:city_id])
  end

  def construction_params
    params.require(:construction).permit(:building_id, :patrol_id, :city_id)
  end
end
