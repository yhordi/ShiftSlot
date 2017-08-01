class LandingsController < ApplicationController
  skip_before_action :require_login, only: :index
  def index
    render 'index'
  end
end
