class OrganizationsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @org = Organization.new
  end

  def create
    @org = Organization.new(org_params)
    if @org.save
      if current_user
        Assignment.create(user_id: current_user.id, organization_id: @org.id)
        current_user.admin = @org
        flash[:notice] = "You've created #{@org.name} and have been granted admin status"
        redirect_to organization_path(@org)
      else
        redirect_to "/users/new?org_id=#{@org.id}?admin=true"
      end
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

  def edit
    if current_user.admin?(params[:id])
      @org = Organization.find(params[:id])
      render 'edit'
    else
      redirect_to organization_shows_path(params[:id])
    end
  end

  def update
    @org = Organization.find(params[:id])
    @org.update(org_params)
    flash[:notice] = 'Organization Details Updated'
    redirect_to organization_path(@org)
  end

  def destroy
    @org = Organization.find(params[:id])
    @org.delete
    flash[:notice] = 'Organization Deleted'
    redirect_to root_path
  end

  private

  def org_params
    params.require(:organization).permit(:name, :gcal_id)
  end
end
