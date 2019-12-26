class BuildingsController < ApplicationController
  def create
    building = Building.new(building_params)
    if building.save
      patrol.save
      flash[:success] = 'Le batiment a été créée.'
      redirect_to patrol_path(patrol.id)
    else
      render 'show'
    end
  end

  def index
    @buildings = Building.all
  end

  def building_params
    params.require(:building).permit(:cost, :durability, :type, :multiplicator)
  end
end
