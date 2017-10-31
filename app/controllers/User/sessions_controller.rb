
class User::SessionsController < Devise::SessionsController
  # skip_before_action :require_login

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    if params['org_name']
      @org = Organization.find_by(name: params[:org_name])
    else
      @orgs = Organization.all
    end
    super
  end

  # POST /resource/sign_in
  def create
    super
    if !user_signed_in?
      @orgs = Organization.all
    end
    session[:organization_id] = params[:organization_id]
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
