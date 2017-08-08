module ShiftsHelper

  def available?(show, shifts)
    shifts.map do |shift|
      return false if shift.show.date == show.date
      true
    end
  end
end
