class MiningsController < ApplicationController
  before_action :authenticate_user!

  def create
    mining = Mining.new(mining_params)
    return unless mining.man_power.present?

    if mining.man_power <= patrol.money && mining.save
      patrol.money -= mining.man_power
      patrol.save
      flash[:success] = 'Les hommes sont partis à la mine.'
    else
      flash[:alert] = 'Pas assez de thune'
    end
    redirect_to patrol_path(patrol.id)
  end

  def destroy
    mining = Mining.find(params[:id])
    mining.patrol.money += mining.man_power
    mining.destroy!
    mining.patrol.save!
    redirect_to patrol_path(mining.patrol.id)
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
