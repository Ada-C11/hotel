module HotelBooking
  class ReservationSystem
    def initialize(hotel_name, number_of_rooms)
      @hotel = Hotel.new(hotel_name: hotel_name, number_of_rooms: number_of_rooms)
    end

    def find_room_by_booking_number(booking_number)
      @hotel.bookings.find { |b| b.reference_number == booking_number }
    end

    def find_bookings_by_room_number(room_number)
      @hotel.bookings.select { |b| b.room.number == room_number }
    end

    def find_room_by_room_number(room_number)
      @hotel.rooms.find { |r| r.number == room_number }
    end

    def find_booking_by_date(start_date, end_date)
      bookings = @hotel.bookings.select do |b|
        b.overlaps?(start_date, end_date)
      end
      bookings
    end

    def get_available_rooms(start_date, end_date)
      unavailable_bookings = find_booking_by_date(start_date, end_date)
      occpuied_rooms = unavailable_bookings.map { |b| b.room }
      @hotel.rooms.reject { |r| occpuied_rooms.include?(r) }
    end

    def available?(start_date, end_date, room_number)
      rooms_available = get_available_rooms(start_date, end_date)
      room_numbers = rooms_available.map { |r| r.number }
      room_numbers.include?(room_number)
    end

    def make_booking(start_date, end_date, room_number = nil)
      selected_room = nil

      if start_date > end_date
        raise ArgumentError.new('Invalid date range')
      end

      if room_number.nil?
        available_rooms = get_available_rooms(start_date, end_date)
        selected_room = available_rooms.first
      elsif available?(start_date, end_date, room_number)
        selected_room = find_room_by_room_number(room_number)
      else
        raise ArgumentError.new('Room is not available')
      end

      booking_details = {
        reference_number: @hotel.bookings.length + 1,
        room: selected_room,
        start_date: start_date,
        end_date: end_date,
        price: 200
      }
      new_booking = Booking.new(booking_details)

      @hotel.add_booking(new_booking)
      new_booking
    end
  end
end
