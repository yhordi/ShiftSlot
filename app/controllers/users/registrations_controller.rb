class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    if params['org_id']
      @org = Organization.find(params[:org_id])
      if @org.any_admins?
        return redirect_to root_path
      end
    else
      @orgs = Organization.all
    end
    super
  end

  # POST /resource
  # def create
  #   @orgs = Organization.all
  #   super do |resource|
  #     resource.organizations << Organization.find(params[:organization_id].to_i)
  #   end
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:organization_id])
  end

  def after_sign_up_path_for(resource)
    if params[:organization_id]
      org = Organization.find(params[:organization_id])
      Assignment.create_and_authorize(user_id: resource.id, organization_id: org.id)
      resource.admin = org
      organization_path(org)
    else
      new_user_assignment_path(resource.id)
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
