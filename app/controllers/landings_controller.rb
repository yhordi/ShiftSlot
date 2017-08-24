class LandingsController < ApplicationController
  skip_before_action :require_login, only: :index
  def index
    @shows = Show.all
    render 'index'
  end
end
