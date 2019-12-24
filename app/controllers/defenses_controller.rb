class DefensesController < ApplicationController
  def create
    defense = Defense.new(defense_params)
    if defense.save
      patrol = defense.patrol
      patrol.money -= defense.man_power
      patrol.save
      flash[:success] = 'La défense a été créée.'
      redirect_to patrol_path(patrol.id)
    else
      render 'show'
    end
  end

  def index
    @defenses = Defense.all
  end

  def defense_params
    params.require(:defense).permit(:man_power, :city_id, :patrol_id)
  end
end
