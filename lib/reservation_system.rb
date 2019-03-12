require_relative "hotel"
require_relative "room"
require_relative "booking"

module HotelBooking
  class ReservationSystem
    attr_accessor :rooms, :bookings, :start_date, :end_date


    # Can find specific room if provided the booking number
    def find_room_by_number(booking_number)
      room = @bookings.find { |booking| booking.reference_number == booking_number }
      return room
    end

    # Can find specific booking if provided the room number
    def find_booking_by_number(room_number)
      booking = @bookings.find { |booking| booking.room == room_number }
      return booking
    end

    # Can find specific bookings for a date when provided date
    def find_booking_by_date(date)
      booking = @bookings.select { |booking| booking.date.include?(date) }
      return booking
    end

    # Can request a trip based on given dates
    def request_trip(start_date, end_date)

      if start_date > end_date
        raise ArgumentError.new("Invalid date range")
      end

      booking_details = {
        reference_number: bookings,
        room: @rooms,
        start_date: start_date,
        end_date: end_date,
        price: 200
      }
      booking_1 = Booking.new(booking_details)

      add_booking(booking_1)
      bookings.push(booking_1)
      return booking_1

    end
  end
end
