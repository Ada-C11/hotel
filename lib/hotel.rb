require_relative "room"
require_relative "reservation"

module HotelSystem
  RATE_PER_NIGHT = 200
  NUMBER_OF_ROOMS = 20

  class Hotel
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      (1..NUMBER_OF_ROOMS).each do |num|
        rooms << room(id: num, rate: RATE_PER_NIGHT)
      end
      @reservations = []
    end

    def make_reservation(room_id, date1, date2)
      room_being_reserved = find_room_by_id(room_id)
      (raise ArgumentError, "Room with id #{room_id} does not exist!") if !room_being_reserved
      request_range = date_range(date1, date2)
      if !room_being_reserved.is_available?(request_range)
        raise ArgumentError, "The room you requested is not available on the given dates!"
      end
      new_reservation = reservation(date_range: request_range,
                                    room: room_being_reserved,
                                    id: (reservations.length + 1))
      room_being_reserved.add_reservation(new_reservation)
      reservations << new_reservation
      return new_reservation
    end

    def list_reservations_by_date(date)
      date = parse_date(date)
      reservations_on_date = reservations.select { |reservation| reservation.includes_date?(date) }
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

    private

    def parse_date(date_string)
      return Date.parse(date_string)
    end

    def date_range(date1, date2)
      return HotelSystem::DateRange.new(date1, date2)
    end

    def room(id: id, rate: rate)
      return HotelSystem::Room.new(id: id, rate: rate)
    end

    def reservation(date_range: date_range, room: room, id: id)
      HotelSystem::Reservation.new(date_range: date_range, room: room, id: id)
    end
  end
end
