class AttacksController < ApplicationController
  def create
    attack = Attack.new(attack_params)
    return unless attack.man_power.present?

    if attack.man_power <= patrol.money && attack.save
      patrol.money -= attack.man_power
      patrol.save
      flash[:success] = "L'attaque a été créée."
    else
      flash[:alert] = 'Pas assez de thune'
    end
    redirect_to patrol_path(patrol.id)
  end

  def destroy
    attack = Attack.find(params[:id])
    attack.patrol.money += attack.man_power
    attack.destroy!
    attack.patrol.save!
    redirect_to patrol_path(attack.patrol.id)
  end

  def patrol
    @patrol ||= Patrol.find(attack_params[:patrol_id])
  end

  def attack_params
    params.require(:attack).permit(:man_power, :city_id, :patrol_id)
  end
end
