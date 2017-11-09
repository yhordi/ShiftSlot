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
    @org = Organization.find(params[:id])
  end

  private

  def org_params
    params.require(:organization).permit(:name, :gcal_id)
  end
end
