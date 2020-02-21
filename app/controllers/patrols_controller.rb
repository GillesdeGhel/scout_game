class PatrolsController < ApplicationController
  def show
    if current_user.troop == patrol.troop || current_user.admin?
      @patrol = patrol
      @attack = Attack.new
      @defense = Defense.new
      @mining = Mining.new
      @construction = Construction.new
    else
      flash[:alert] = 'Pas votre patrouille'
      redirect_to root_path
    end
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
