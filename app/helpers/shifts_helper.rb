module ShiftsHelper

  def available?(show, shifts)
    return true if shifts.empty?
    shifts.each do |shift|
      return false if shift.show.date == show.date
      return true
    end
  end
end
