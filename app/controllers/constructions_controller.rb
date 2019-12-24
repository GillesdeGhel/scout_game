class ConstructionsController < ApplicationController
  def create
    construction = Construction.new(construction_params)
    if construction.save
      patrol = construction.patrol
      patrol.money -= construction.building.cost
      patrol.save
      flash[:success] = "Les hommes ont construit #{construction.building.name} "
      redirect_to patrol_path(patrol.id)
    else
      render 'show'
    end
  end

  def index
    @constructions = Construction.all
  end

  def construction_params
    params.require(:construction).permit(:building_id, :patrol_id)
  end
end
