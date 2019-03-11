require "date"

class Reservation
  attr_reader :first_night, :last_night

  def initialize(start_date, end_date)
    @first_night = start_date
    @last_night = end_date - 1
  end
end
