class LandingsController < ApplicationController
  skip_before_action :require_login, only: :index
  def index
    @shifts = Show.available_shifts_for(current_user)
    render 'index'
  end
end
