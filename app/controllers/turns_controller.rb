class TurnsController < ApplicationController
  def end_turn
    Patrol.all.each do |p|
      p.money += 100
      p.save!
    end
    redirect_to root_path
  end
end
