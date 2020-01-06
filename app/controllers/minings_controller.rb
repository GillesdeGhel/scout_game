class MiningsController < ApplicationController
  def create
    mining = Mining.new(mining_params)
    if mining.man_power <= patrol.money && mining.save
      patrol.money -= mining.man_power
      patrol.save
      flash[:success] = 'Les hommes sont partis à la mine.'
    else
      flash[:alert] = 'Pas assez de thune'
    end
    redirect_to patrol_path(patrol.id)
  end

  def index
    @minings = Mining.all
  end

  def patrol
    @patrol ||= Patrol.find(mining_params[:patrol_id])
  end

  def mining_params
    params.require(:mining).permit(:man_power, :patrol_id)
  end
end
