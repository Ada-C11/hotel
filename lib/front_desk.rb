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
      @rooms = generate_rooms_array

      @reservations = []

      @blocks = []
    end

    def reserve_room(check_in:, check_out:, room_number: nil)
      nights = generate_nights(check_in: check_in, check_out: check_out)

      if room_number
        room = find_room_by_number(room_number: room_number)
        validate_room(room: room)
      end

      if room && !room.available?(nights: nights)
        raise AvailabilityError, "That room is not available for those dates"
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

      first_open_room_in_block = block.rooms.first

      room ||= first_open_room_in_block

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
      validate_date_arguments(check_in: check_in, check_out: check_out, nights: nights)

      nights ||= generate_nights(check_in: check_in, check_out: check_out)

      rooms.select { |room| room.available?(nights: nights) }
    end

    def create_block(check_in:, check_out:, room_collection: nil, number_of_rooms: nil, room_rate:)
      unless room_collection || number_of_rooms
        raise ArgumentError, "Must include room_collection or number_of_rooms"
      end

      if room_collection && number_of_rooms
        unless room_collection.length == number_of_rooms
          raise ArgumentError, "Number of rooms does not match room_collection length"
        end
      end

      nights = generate_nights(check_in: check_in, check_out: check_out)
      number_of_rooms = room_collection.length if room_collection
      validate_size(number_of_rooms: number_of_rooms) if number_of_rooms

      rooms = []
      if number_of_rooms && !room_collection
        number_of_rooms.times { rooms << assign_room(nights: nights) }
      elsif room_collection
        rooms = room_collection.map { |room_number| find_room_by_number(room_number: room_number) }
      end

      rooms.each do |room|
        validate_room(room: room)
        raise AvailabilityError, "Rooms are unavailable for that date range" unless room.available?(nights: nights)
      end

      block = Hotel::Block.new(nights: nights,
                               room_collection: rooms,
                               room_rate: room_rate,
                               id: blocks.length + 1)

      blocks << block

      rooms.each { |room| room.book(nights: nights) }

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

      (check_in...check_out).to_a # doesn't include checkout day
    end

    def assign_room(nights:)
      open = open_rooms(nights: nights)

      raise AvailabilityError, "No rooms available for those dates" if open.empty?

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

    def validate_size(number_of_rooms:)
      max_rooms_for_block = 5
      raise ArgumentError, "Block can contain maximum of 5 rooms" if number_of_rooms > max_rooms_for_block
    end

    def validate_dates(check_in:, check_out:)
      raise ArgumentError, "Reservation must be at least one day long" if check_in >= check_out
    end

    def validate_date_arguments(check_in: nil, check_out: nil, nights: nil)
      unless (check_in && check_out) || nights
        raise ArgumentError, "Either check in and check out dates or a list of nights must be given"
      end
    end
  end
end
