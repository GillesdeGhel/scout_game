class PatrolsController < ApplicationController
  def show
    @patrol = Patrol.find(params[:id])
    @attack = Attack.new
    @defense = Defense.new
    @mining = Mining.new
  end
end
