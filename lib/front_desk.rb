require "date"

require_relative "room"
require_relative "reservation"
require_relative "block"

module Hotel
  class FrontDesk
    NUMBER_OF_ROOMS = 20

    attr_reader :rooms, :reservations

    def initialize
      @reservations = []

      @rooms = rooms_array
    end

    def reserve_room(check_in: nil, check_out: nil, room_number: nil)
      nights = generate_nights(check_in: check_in, check_out: check_out)

      room = find_room_by_number(room_number: room_number) if room_number

      if room && room.available?(range: nights) == false
        raise ArgumentError, "That room is not available for those dates"
      end

      room ||= assign_room(nights: nights)

      reservation = Hotel::Reservation.new(nights: nights,
                                           room: room)

      reservation.room.booked_nights.concat(nights)

      reservations << reservation

      return reservation
    end

    def find_reservations_by_date(date:)
      date = Date.parse(date)

      reservations.select { |reservation| reservation.nights.include?(date) }
    end

    def find_room_by_number(room_number:)
      found_room = rooms.find { |room| room.number == room_number }
      raise ArgumentError, "That room doesn't exist" unless found_room
      return found_room
    end

    def open_rooms(check_in: nil, check_out: nil, nights: nil)
      unless (check_in && check_out) || nights
        raise ArgumentError, "Either check in and check out dates or a list of nights must be given"
      end

      nights ||= generate_nights(check_in: check_in, check_out: check_out)

      rooms.select { |room| room.available?(range: nights) }
    end

    def reserve_block(range:, room_collection:, room_rate:)
      # ASSUME FOR NOW THAT:
      ### range is an array of Dates
      ### room_collection is an array of room numbers
      ### room_rate is an integer price per night
      rooms = room_collection.map { |room_number| find_room_by_number(room_number: room_number) }

      rooms.each do |room|
        raise ArgumentError, "Rooms are available for that date range" unless room.available?(range: range)
      end

      Hotel::Block.new(range: range, room_collection: room_collection, room_rate: room_rate)
    end

    private

    def rooms_array
      rooms = []
      NUMBER_OF_ROOMS.times { |i| rooms << Hotel::Room.new(room_number: i + 1) }
      return rooms
    end

    def generate_nights(check_in:, check_out:)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)

      if check_in >= check_out
        raise ArgumentError, "Reservation must be at least one day long"
      end

      nights = []
      night = check_in
      until night == check_out # not including checkout day
        nights << night
        night += 1 # go to the next day
      end
      return nights
    end

    def assign_room(nights:)
      open = open_rooms(nights: nights)

      if open == []
        raise ArgumentError, "No rooms available for those dates"
      else
        return open.first
      end
    end
  end
end
