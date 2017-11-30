class OrganizationsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :confirm]

  def new
    @org = Organization.new
  end

  def create
    @org = Organization.new(org_params)
    if @org.save
      # redirect_to "/users/new?org_id=#{@org.id}"
      redirect_to "/organizations/#{@org.id}/confirm"
    else
      flash[:errors] = @org.errors.full_messages
      redirect_to new_organization_path
    end
  end

  def show
    if current_user.admin?(params[:id])
      @org = Organization.find(params[:id])
    else
      redirect_to organization_shows_path(params[:id])
    end
  end

  def confirm
    @org = Organization.find(params[:organization_id])
    render 'confirm'
  end

  private

  def org_params
    params.require(:organization).permit(:name, :gcal_id)
  end
end
