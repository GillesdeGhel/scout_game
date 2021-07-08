class DefensesController < ApplicationController
  before_action :authenticate_user!

  def create
    defense = Defense.new(defense_params)
    return unless defense.man_power.present?

    if defense.man_power <= patrol.money && defense.save
      patrol.money -= defense.man_power
      patrol.save
      flash[:success] = 'La défense a été créée.'
    else
      flash[:alert] = 'Pas assez de thune'
    end
    redirect_to patrol_path(patrol.id)
  end

  def destroy
    defense = Defense.find(params[:id])
    defense.patrol.money += defense.man_power
    defense.destroy!
    defense.patrol.save!
    redirect_to patrol_path(defense.patrol.id)
  end

  def patrol
    @patrol ||= Patrol.find(defense_params[:patrol_id])
  end

  def defense_params
    params.require(:defense).permit(:man_power, :city_id, :patrol_id)
  end
end
