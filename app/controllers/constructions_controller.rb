class ConstructionsController < ApplicationController
  def create
    construction = Construction.new(construction_params)
    if building.cost <= patrol.money && construction.save
      construction.update!(durability: building.durability)
      cost_multiplicator = building.usage.eql?('defense') ? patrol.defense_construction_cost_multiplicator : patrol.attack_construction_cost_multiplicator
      patrol.money -= building.cost * cost_multiplicator
      city.defense_building_multiplicator += building.multiplicator if building.usage.eql?('defense')
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
