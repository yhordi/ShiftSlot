class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception

  private

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to access this section"
      redirect_to root_path
    end
  end
end
