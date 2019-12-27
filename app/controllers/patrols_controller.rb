class PatrolsController < ApplicationController
  def show
    @patrol = patrol
    @attack = Attack.new
    @defense = Defense.new
    @mining = Mining.new
    @construction = Construction.new
  end

  def update
    if patrol.update(patrol_params)
      flash[:success] = 'Guilde changée'
    else
      flash[:alert] = 'Erreur, pas possible'
    end
    redirect_to patrol_path(patrol)
  end

  def patrol
    @patrol ||= Patrol.find(params[:id])
  end

  private

  def patrol_params
    params.require(:patrol).permit(:guild_id)
  end
end
