class OrganizationsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @org = Organization.new
  end

  def create
    @org = Organization.new(org_params)
    if @org.save
      # need to nest users inside organizations
      redirect_to new_user_registration_path
    else
      flash[:errors] = @org.errors.full_messages
      redirect_to new_organization_path
    end
  end

  def show
  end

  private

  def org_params
    params.require(:organization).permit(:name, :gcal_id)
  end
end
