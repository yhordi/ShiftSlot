class PreferredDaysController < ApplicationController

  def create
    params[:days].each do |day|
      if params[:days][day] == 'false'
        PreferredDay.create(name: day, preferred: false, user_id: params[:user_id])
      else params[:days][day] == 'true/'
        PreferredDay.create(name: day, preferred: true, user_id: params[:user_id])
      end
    end
    flash[:notice] = 'days updated'
    redirect_to edit_user_path(params[:user_id])
  end

  def update
  end

end
