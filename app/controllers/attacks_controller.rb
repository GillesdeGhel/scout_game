class AttacksController < ApplicationController
  def create
    attack = Attack.new(attack_params)
    if attack.save
      redirect_to attacks_path
    else
      render patrol_path(params[:id])
    end
  end

  def index
    @attacks = Attack.all
  end

  def attack_params
    params.require(:attack).permit(:man_power, :city_id, :patrol_id)
  end
end
