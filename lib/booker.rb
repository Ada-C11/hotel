require_relative "room"
require_relative "date_range"
require_relative "reservation"
# require_relative "block"

require "pry"

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

    binding.pry

    def reserve(start_date:, end_date:, price: 200)
      id = assign_id(reservations)
      date_range = date_range(start_date, end_date)
      room = open_room(date_range)
      raise ArgumentError, "No rooms avaialable" if room == nil
      reservation = reservation_wrapper(id, date_range, room, price)
      binding.pry
      add_reservation(reservation)
      room.add_reservation(reservation)
      return reservation
    end

    # def find_room(room_id)
    #   return rooms.find { |room| room.id == room_id }
    # end

    def available_rooms(date_range)
      return rooms.select do |room|
               room.is_available?(date_range)
             end
    end

    def open_room(date_range)
      return available_rooms(date_range).find { |room| room }
    end

    def reservation_by_date(date_range)
      return reservations.select do |reservation|
               reservation.match?(date_range)
             end
    end

    private

    # factory/wrapper methods
    def assign_id(objects)
      id = objects.count + 1
    end

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
