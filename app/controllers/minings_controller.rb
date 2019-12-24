class MiningsController < ApplicationController
  def create
    mining = Mining.new(mining_params)
    if mining.save
      patrol = mining.patrol
      patrol.money -= mining.man_power
      patrol.save
      flash[:success] = 'Les hommes sont partis à la mine.'
      redirect_to patrol_path(patrol.id)
    else
      render 'show'
    end
  end

  def index
    @minings = Mining.all
  end

  def mining_params
    params.require(:mining).permit(:man_power, :patrol_id)
  end
end
