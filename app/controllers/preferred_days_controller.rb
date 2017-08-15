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
    user = User.find(params[:user_id])
    day = PreferredDay.find(params[:id])
    day.update(day_params)
    flash[:notice] = "#{day.name} availability updated"
    render partial: 'day_form', locals: {day: day, user: user}
  end

  private

  def day_params
    params.require(:preferred_day).permit(:preferred)
  end

end
