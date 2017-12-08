class AssignmentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    render :new
  end
end
