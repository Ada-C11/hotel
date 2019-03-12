require 'date'

class Booking

  attr_reader :room, :start_date, :end_date, :price

  def initialize(room:, start_date:, end_date:, price: 200)
    @room = room
    @start_date = start_date
    @end_date = end_date
    @price = 200
  end

  def booking_duration
    duration = @end_date - @start_date
    duration.to_i 
  end

  def booking_cost
    self.booking_duration  * price
  end
end
