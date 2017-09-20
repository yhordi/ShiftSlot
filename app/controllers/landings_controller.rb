class LandingsController < ApplicationController
  skip_before_action :require_login, only: :index
  def index
    if current_user
      @shifts = Show.available_shifts_for(current_user)
    end
    render 'index'
  end
end
