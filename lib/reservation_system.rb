module HotelBooking
  class ReservationSystem

    def initialize
      @hotel = Hotel.new(hotel_name: 'Wyndham', number_of_rooms: 20)
    end

    # Can find specific room if provided the booking number
    def find_room_by_booking_number(booking_number)
      room = @hotel.bookings.find { |booking| booking.reference_number == booking_number}
      return room
    end

    # Can find specific bookings if provided the room number
    def find_bookings_by_room_number(room_number)
      bookings = @hotel.bookings.select { |booking| booking.room.number == room_number}
      return bookings
    end

    # Can find specific bookings for a date when provided date
    def find_booking_by_date(date)
      bookings = @hotel.bookings.select do |booking|
        booking.start_date <= date && booking.end_date >= date
      end
      return bookings
    end

    # Can find available rooms if given a start and end date
    def get_available_rooms(start_date, end_date)

      all_bookings = find_booking_by_date(start_date)
      unavailable_bookings = all_bookings.select { |booking| booking.end_date <= end_date}

      occpuied_rooms = []
      unavailable_bookings.each do |booking|
        occpuied_rooms.push(booking.room)
      end

      available_rooms = []
      @hotel.rooms.each do |room|
        unless occpuied_rooms.include?(room)
          available_rooms.push(room)
        end
      end
      return available_rooms
    end

    # Returns true or false if specific room is available for given date
    def available?(start_date, end_date, room_number)

      rooms_available = get_available_rooms(start_date, end_date)
      room_numbers = rooms_available

      if room_numbers.include?(room_number)
        return true
      else
        return false
      end
    end

    # maybe make a booking block

    # Makes your booking when given date range
    # add number of rooms and price set default unless its is block

    def make_booking(start_date, end_date)

      if start_date > end_date
        raise ArgumentError.new("Invalid date range")
      end

      available_rooms = get_available_rooms(start_date, end_date)
      selected_room = available_rooms.first

      if available?(start_date, end_date, selected_room)
        booking_details = {
          reference_number: @hotel.bookings.length + 1,
          room: selected_room,
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
end
