require "date"

class Reservation
  PRICE = 200

  attr_reader :first_night, :last_night, :length_of_stay, :cost

  def initialize(start_date, end_date)
    @first_night = start_date
    @last_night = end_date - 1
    @length_of_stay = end_date - start_date
    @cost = @length_of_stay * PRICE
  end
end
