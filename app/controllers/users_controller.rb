class UsersController < ApplicationController
  def index
    if current_user
    @users = User.all
    render :index
    else
      redirect_to root_path
    end
  end
end
