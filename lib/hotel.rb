require_relative "room"
require_relative "reservation"
require_relative "block"
require_relative "err/errors"

module HotelSystem
  RATE_PER_NIGHT = 200
  NUMBER_OF_ROOMS = 20

  class Hotel
    attr_reader :rooms, :reservations, :blocks

    def initialize
      @rooms = []
      (1..NUMBER_OF_ROOMS).each do |num|
        rooms << room(id: num, rate: RATE_PER_NIGHT)
      end
      @reservations = {}
      @blocks = {}
    end

    def make_reservation(room_id:, start_date:, end_date:, name:)
      room_being_reserved = find_room_by_id(room_id)
      (raise RoomError, "Room with id #{room_id} does not exist!") if !room_being_reserved
      request_range = date_range(start_date, end_date)
      check_room(room: room_being_reserved, date_range: request_range)
      new_res = reservation(date_range: request_range,
                            room: room_being_reserved,
                            id: (reservations.length + 1), name: name)
      update_reservations(room: room_being_reserved, reservation: new_res)
      return new_res
    end

    def make_block
    end

    def list_reservations_by_date(date)
      date = parse_date(date)
      reservations_on_date = reservations.values.select { |reservation| reservation.includes_date?(date) }
      return reservations_on_date
    end

    def list_available_rooms(date)
      reserved = list_reservations_by_date(date)
      reserved.map! { |reservation| reservation.room }
      available_rooms = rooms - reserved
      return available_rooms
    end

    def find_room_by_id(room_id)
      return rooms.find { |room| room.id == room_id }
    end

    def reserve_from_block(block, room, name)
      (raise BlockError, "The given block does not contain the given room") if (!room.blocks.include?(block))
      check_room(room: room, date_range: block.date_range, from_block: true)
      new_res = reservation(date_range: block.date_range,
                            id: (reservations.length + 1),
                            room: room,
                            name: name)
      update_reservations(block: block, room: room, reservation: new_res)
      return new_res
    end

    def add_reservation(reservation)
      reservations[reservation.name] = reservation
    end

    private

    def update_reservations(block: nil, room: nil, reservation:)
      self.add_reservation(reservation)
      block.add_reservation(reservation) if block
      room.add_reservation(reservation) if room
    end

    def check_room(room:, date_range:, from_block: false)
      if !room.is_available?(date_range)
        raise ReservationError, "The room you requested is not available on the given dates!"
      end
      if room.is_blocked?(date_range) && !from_block
        raise BlockError, "The room you requested is blocked on the given dates!"
      end
    end

    def parse_date(date_string)
      return Date.parse(date_string)
    end

    def date_range(date1, date2)
      return HotelSystem::DateRange.new(date1, date2)
    end

    def room(id:, rate:)
      return HotelSystem::Room.new(id: id, rate: rate)
    end

    def reservation(date_range:, room:, id:, name:)
      HotelSystem::Reservation.new(date_range: date_range, room: room, id: id, name: name)
    end

    def block(rooms:, date_range:, discount_rate:, id:)
      HotelSystem::Block.new(rooms: rooms, date_range: date_range, discount_rate: discount_rate)
    end
  end
end
