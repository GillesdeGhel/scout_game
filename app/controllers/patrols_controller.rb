class PatrolsController < ApplicationController
  def show
    @patrol = Patrol.find(params[:id])
    @attack = Attack.new
  end
end
