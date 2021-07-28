class HomeController < ApplicationController
  def show
    render plain: "Les résultats seront disponibles à midi le 29/07" unless current_user&.admin?
  end
end
