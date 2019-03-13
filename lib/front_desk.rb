require "date"

require_relative "room"
require_relative "reservation"

module Hotel
  class FrontDesk
    NUMBER_OF_ROOMS = 20

    attr_reader :rooms, :reservations

    def initialize
      @reservations = []

      @rooms = rooms_array
    end

    def reserve(check_in:, check_out:, room_number: nil)
      nights = generate_nights(check_in: check_in, check_out: check_out)

      room = find_room_by_number(room_number: room_number) if room_number

      room ||= assign_room(array_of_nights: nights)

      raise ArgumentError, "Room not available" unless room.available?(range: nights)

      reservation = Hotel::Reservation.new(nights: nights,
                                           room: room)

      reservation.room.booked_nights.concat(nights)

      reservations << reservation

      return reservation
    end

    def find_reservations_by_date(date:)
      date = Date.parse(date)
      on_this_date = []

      reservations.select { |reservation| reservation.nights.include?(date) }
    end

    def find_room_by_number(room_number:)
      found_room = rooms.find { |room| room.number == room_number }
      raise ArgumentError, "That room doesn't exist" unless found_room
      return found_room
    end

    def open_rooms(check_in: nil, check_out: nil, nights: nil)
      unless (check_in && check_out) || nights
        raise ArgumentError, "Check in and check out dates or a list of nights must be given"
      end

      nights ||= generate_nights(check_in: check_in, check_out: check_out)

      avail_rooms = rooms.select do |room|
        room.available?(range: nights)
      end

      raise ArgumentError, "No rooms available" if avail_rooms == []

      return avail_rooms
    end

    private

    def rooms_array
      rooms = []
      NUMBER_OF_ROOMS.times { |i| rooms << Hotel::Room.new(room_number: i + 1) }
      return rooms
    end

    def generate_nights(check_in:, check_out:)
      first_day = Date.parse(check_in)
      last_day = Date.parse(check_out)

      if first_day >= last_day
        raise ArgumentError, "Reservation must be at least one day long"
      end

      nights = []
      night = first_day
      until night == last_day # not including last day
        nights << night
        night += 1 # go to the next day
      end
      return nights
    end

    def assign_room(array_of_nights:)
      open_rooms(nights: array_of_nights).first
    end
  end
end
