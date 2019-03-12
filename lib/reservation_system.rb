require_relative "hotel"
require_relative "room"
require_relative "booking"
require_relative "date"

class ReservationSystem
  attr_accessor :start_date, :end_date

  def request_trip(start_date, end_date)

    if start_date > end_date
      raise ArgumentError.new("Invalid date range")
    end

    booking_details = {
      reference_number: @bookings.length + 1,
      room: @rooms.first,
      start_date: start_date,
      end_date: end_date,
      price: 200
    }
    booking_1 = Booking.new(booking_details)

    add_booking(booking_1)
    @bookings.push(booking_1)
    return booking_1

  end
end
