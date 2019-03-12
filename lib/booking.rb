require 'date'

class Booking
attr_reader :reference_number, :room, :start_date, :end_date, :price

  def initialize(reference_number:, room:, start_date:, end_date:, price: 200)
    @reference_number = reference_number
    @room = room
    @start_date = start_date
    @end_date = end_date
    @price = price
  end

  def booking_duration
    duration = @end_date - @start_date
    duration.to_i
  end

  def booking_cost
    self.booking_duration * price
  end
end
