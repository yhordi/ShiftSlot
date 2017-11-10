class OrganizationsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @org = Organization.new
  end

  def create
    @org = Organization.new(org_params)
    if @org.save
      redirect_to "/users/new?org_id=#{@org.id}"
    else
      flash[:errors] = @org.errors.full_messages
      redirect_to new_organization_path
    end
  end

  def show
    p params
    p current_user.admin?(params[:id])
    if current_user.admin?(params[:id])
      @org = Organization.find(params[:id])
    else
      redirect_to organization_shows_path(params[:id])
    end
  end

  private

  def org_params
    params.require(:organization).permit(:name, :gcal_id)
  end
end
