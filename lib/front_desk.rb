require "date"

require_relative "room"
require_relative "reservation"
require_relative "block"
require_relative "custom_errors"

module Hotel
  class FrontDesk
    NUMBER_OF_ROOMS = 20

    attr_reader :rooms, :reservations, :blocks

    def initialize
      @reservations = []

      @rooms = generate_rooms_array

      @blocks = []
    end

    def reserve_room(check_in:, check_out:, room_number: nil)
      nights = generate_nights(check_in: check_in, check_out: check_out)

      if room_number
        room = find_room_by_number(room_number: room_number)
        validate_room(room: room)
      end

      if room && !room.available?(nights: nights)
        raise ArgumentError, "That room is not available for those dates"
      end

      room ||= assign_room(nights: nights)

      reservation = Hotel::Reservation.new(nights: nights, room: room)

      room.book(nights: nights)

      add_to_reservations(reservation: reservation)

      return reservation
    end

    def reserve_room_in_block(id:, room_number: nil)
      block = find_block_by_id(id: id)

      validate_block(block: block)

      raise AvailabilityError, "No rooms available in block" unless block.has_available_rooms?

      if room_number
        room = find_room_by_number(room_number: room_number)

        validate_room(room: room)

        raise AvailabilityError, "Room #{room.number} is not available in block" unless block.rooms.include?(room)
      end

      room ||= block.rooms.first

      reservation = Hotel::Reservation.new(room: room,
                                           nights: block.nights,
                                           block_id: id,
                                           rate: block.room_rate)

      block.book(room: room)

      add_to_reservations(reservation: reservation)

      return reservation
    end

    def find_block_by_id(id:)
      blocks.find { |block| block.id == id }
    end

    def find_reservations_by_date(date:)
      date = Date.parse(date)

      reservations.select { |reservation| reservation.nights.include?(date) }
    end

    def find_room_by_number(room_number:)
      rooms.find { |room| room.number == room_number }
    end

    def open_rooms(check_in: nil, check_out: nil, nights: nil)
      unless (check_in && check_out) || nights
        raise ArgumentError, "Either check in and check out dates or a list of nights must be given"
      end

      nights ||= generate_nights(check_in: check_in, check_out: check_out)

      rooms.select { |room| room.available?(nights: nights) }
    end

    def create_block(range:, room_collection:, room_rate:)
      # ASSUME FOR NOW THAT:
      ### range is an array of Dates, check-in to check-out
      ### room_collection is an array of room numbers
      ### room_rate is an integer price per night

      validate_size(room_collection: room_collection)

      rooms = room_collection.map { |room_number| find_room_by_number(room_number: room_number) }

      rooms.each do |room|
        validate_room(room: room)
        raise ArgumentError, "Rooms are unavailable for that date range" unless room.available?(nights: range)
      end

      # this part is confunsing a little

      range.pop

      block = Hotel::Block.new(nights: range,
                               room_collection: rooms,
                               room_rate: room_rate,
                               id: blocks.length + 1)

      blocks << block

      rooms.each { |room| room.book(nights: range) }

      return block
    end

    private

    def generate_rooms_array
      rooms = []
      NUMBER_OF_ROOMS.times { |i| rooms << Hotel::Room.new(room_number: i + 1) }
      return rooms
    end

    def generate_nights(check_in:, check_out:)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)

      validate_dates(check_in: check_in, check_out: check_out)

      (check_in...check_out).to_a # not including checkout day
    end

    def assign_room(nights:)
      open = open_rooms(nights: nights)

      raise ArgumentError, "No rooms available for those dates" if open.empty?

      return open.first
    end

    def add_to_reservations(reservation:)
      reservations << reservation
    end

    def validate_room(room:)
      raise ArgumentError, "Room doesn't exist" unless room
    end

    def validate_block(block:)
      raise ArgumentError, "Block doesn't exist" unless block
    end

    def validate_size(room_collection:)
      raise ArgumentError, "Block can contain maximum of 5 rooms" if room_collection.length > 5
    end

    def validate_dates(check_in:, check_out:)
      raise ArgumentError, "Reservation must be at least one day long" if check_in >= check_out
    end
  end
end
