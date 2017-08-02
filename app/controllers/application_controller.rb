class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to access this section"
      redirect_to root_path
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
