class PatrolsController < ApplicationController
  before_action :authenticate_user!, only: %i[show update]

  def show
    if current_user&.admin?
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
    else
      render plain: "Les résultats seront disponibles à midi le 29/07"
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

  def index
    if current_user&.admin?
      @patrols = Patrol.all
    else
      render plain: "Les résultats seront disponibles à midi le 29/07"
    end
  end

  private

  def patrol_params
    params.require(:patrol).permit(:guild_id, :guild_changed)
  end

  def patrol
    @patrol ||= Patrol.find(params[:id])
  end
end
