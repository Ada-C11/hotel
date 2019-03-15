require_relative "room"
require_relative "date_range"
require_relative "reservation"
# require_relative "block"

module Hotel
  class Booker
    attr_reader :rooms, :reservations

    def initialize
      @rooms = create_rooms(20)
      @reservations = []
    end

    def add_reservation(reservation)
      reservations.push(reservation)
    end

    def reserve(id:, start_date:, end_date:, price: 200)
      date_range = date_range(start_date, end_date)
      open_rooms = avaialable_rooms(date_range)
      raise ArgumentError, "No rooms avaialable" if open_rooms == []
      room = open_rooms[0]
      reservation = reservation_wrapper(id, date_range, room, price)
      add_reservation(reservation)
      room.add_reservation(reservation)
      return reservation
    end

    # def find_room(room_id)
    #   return rooms.find { |room| room.id == room_id }
    # end

    def avaialable_rooms(date_range)
      return rooms.select do |room|
               room.is_available?(date_range)
             end
    end

    private

    # factory/wrapper methods
    def create_rooms(number_of_rooms)
      rooms = (1..number_of_rooms).map do |number|
        Hotel::Room.new(id: number)
      end
      return rooms
    end

    def date_range(start_date, end_date)
      return Hotel::DateRange.new(start_date, end_date)
    end

    def reservation_wrapper(id, date_range, room, price)
      return Hotel::Reservation.new(id: id, date_range: date_range, room: room, price: price)
    end
  end
end
