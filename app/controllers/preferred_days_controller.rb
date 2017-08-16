class PreferredDaysController < ApplicationController

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
