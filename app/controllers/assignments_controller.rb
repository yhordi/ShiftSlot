class AssignmentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @orgs = Organization.all
    render :new
  end

  def create
    @org = Organization.find(params[:organization_id])
    assignment = Assignment.new(user_id: params[:user_id], organization_id: params[:organization_id])
    if assignment.save
      flash[:notice] = "You're signed up for #{@org.name}"
      redirect_to root_path
    else
      flash[:error] = "You were not signed up"
      redirect_back
    end
  end
end
