module HotelBooking
  class ReservationSystem

    def initialize
      @hotel = Hotel.new(hotel_name:'Wyndham', number_of_rooms:20)
    end

    # Can find specific room if provided the booking number
    def find_room_by_booking_number(booking_number)
      room = @hotel.bookings.find { |booking| booking.reference_number == booking_number }
      return room
    end

    # Can find specific booking if provided the room number
    def find_bookings_by_room_number(room_number)
      bookings = @hotel.bookings.select { |booking| booking.room.number == room_number }
      return bookings
    end

    # Can find specific bookings for a date when provided date
    def find_booking_by_date(date)
      date_object = Date.parse(date)
      bookings = @hotel.bookings.select do |booking|
        booking.start_date <= date_object && booking.end_date >= date_object
      end
      return bookings
    end

    # Can request a trip based on given dates
    def request_trip(start_date, end_date)

      if start_date > end_date
        raise ArgumentError.new("Invalid date range")
      end

      booking_details = {
        reference_number: @hotel.bookings.length + 1,
        room: @hotel.rooms.first,
        start_date: start_date,
        end_date: end_date,
        price: 200
      }
      new_booking = Booking.new(booking_details)

      @hotel.add_booking(new_booking)
      return new_booking
    end
  end
end
