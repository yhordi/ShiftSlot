class UsersController < ApplicationController
  def index
    @venues = Venue.order(:name)
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    # needs admin check?
    @user = User.find(params[:id])
    @user.adjust_jobs(params[:job_ids])
    org = Organization.find(params[:organization_id])
    if params[:user]
      if params[:user][:set_admin] == 'true'
        @user.admin = org
        @user.update!(user_params)
      else
        @user.revoke_admin(org.id)
      end
    end
    @user.save!
    flash[:notice] = 'User updated'
    redirect_to edit_user_path(@user.id)
  end

  def search
    @results = User.where('users.name LIKE :query', query: "#{params[:search]}%")
    if @results.length == 0 || params[:search].empty?
      render plain: 'No results matching that query'
    else
      @shift = Shift.find(params[:shift_id])
      @show = Show.find(params[:show_id])
      render partial: 'search_results'
    end
  end
end


private

def user_params
  params.require(:user).permit(:admin)
end
