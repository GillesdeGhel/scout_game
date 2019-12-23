class AttacksController < ApplicationController
  def create
    attack = Attack.new(attack_params)
    if attack.save
      patrol = attack.patrol
      patrol.money -= attack.man_power
      patrol.save
      flash[:success] = 'Le livre a été mis à jour.'
      redirect_to patrol_path(patrol.id)
    else
      render 'show'
    end
  end

  def index
    @attacks = Attack.all
  end

  def attack_params
    params.require(:attack).permit(:man_power, :city_id, :patrol_id)
  end
end
