class DefensesController < ApplicationController
  def create
    defense = Defense.new(defense_params)
    if defense.man_power <= patrol.money && defense.save
      patrol.money -= defense.man_power
      patrol.save
      flash[:success] = 'La défense a été créée.'
    else
      flash[:alert] = 'Pas assez de thune'
    end
    redirect_to patrol_path(patrol.id)
  end

  def patrol
    @patrol ||= Patrol.find(defense_params[:patrol_id])
  end

  def defense_params
    params.require(:defense).permit(:man_power, :city_id, :patrol_id)
  end
end
