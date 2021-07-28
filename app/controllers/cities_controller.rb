class CitiesController < ApplicationController
  def index
    if current_user&.admin?
      @cities = City.all
    else
      render plain: "Les résultats seront disponibles à midi le 29/07"
    end
  end
end
