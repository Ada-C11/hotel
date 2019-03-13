require_relative "room"
require_relative "reservation"
require_relative "block"
require_relative "err/errors"

require "pry"
require "faker"

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

    def find_room_by_id(room_id)
      return rooms.find { |room| room.id == room_id }
    end

    def find_res_by_id(id)
      return reservations[id]
    end

    def find_block_by_id(id)
      return blocks[id]
    end

    def add_reservation(reservation)
      reservations[reservation.id] = reservation
    end

    def add_block(block)
      blocks[block.id] = block
    end

    def all_reservations
      return reservations.values
    end

    def all_blocks
      return blocks.values
    end

    def make_reservation(room_id:, start_date:, end_date:, name:)
      room = find_room_by_id(room_id)
      (raise RoomError, "Room with id #{room_id} does not exist!") if !room
      request_range = date_range(start_date, end_date)
      id = generate_id
      check_room(room: room, date_range: request_range)
      new_res = reservation(date_range: request_range,
                            room: room,
                            id: id, name: name)
      update_reservations(room: room, reservation: new_res)
      return new_res
    end

    def list_reservations_by_date(date)
      date = parse_date(date)
      reservations_on_date = all_reservations.select { |reservation| reservation.includes_date?(date) }
      return reservations_on_date
    end

    def list_available_rooms(date)
      reserved = list_reservations_by_date(date).map! { |reservation| reservation.room }
      available_rooms = rooms - reserved
      return available_rooms
    end

    def make_block(*room_ids, start_date:, end_date:, group_name:, discount_rate:)
      rooms = room_ids.map { |id| find_room_by_id(id) }
      request_range = date_range(start_date, end_date)
      id = generate_id
      rooms.each do |room|
        check_room(room: room, date_range: request_range)
      end
      new_block = block(rooms: rooms,
                        date_range: request_range,
                        discount_rate: discount_rate,
                        id: id,
                        group_name: group_name)
      self.add_block(new_block)
      return new_block
    end

    def reserve_from_block(block_id, room_id, name)
      room = find_room_by_id(room_id)
      block = find_block_by_id(block_id)
      (raise BlockError, "The given block does not contain the given room") if (!(block.has_room?(room)))
      check_room(room: room, date_range: block.date_range, ignore_blocked: true)
      new_res = reservation(date_range: block.date_range,
                            id: (reservations.length + 1),
                            room: room,
                            name: name)
      update_reservations(block: block, room: room, reservation: new_res)
      return new_res
    end

    private

    def generate_id
      id = Faker::Alphanumeric.unique.alphanumeric 10
      return id.upcase
    end

    def update_reservations(block: nil, room: nil, reservation:)
      self.add_reservation(reservation)
      block.add_reservation(reservation) if block
      room.add_reservation(reservation) if room
    end

    def check_room(room:, date_range:, ignore_blocked: false)
      if room.is_reserved?(date_range)
        raise ReservationError, "The room you requested is not available on the given dates!"
      end
      if room.is_blocked?(date_range) && !ignore_blocked
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

    def block(rooms:, date_range:, discount_rate:, id:, group_name:)
      HotelSystem::Block.new(rooms: rooms, date_range: date_range, discount_rate: discount_rate, group_name: group_name, id: id)
    end
  end
end
