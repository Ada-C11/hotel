require_relative 'room'
require_relative 'reservation'

NUM_OF_ROOMS = 20

module BookingSystem
  class Hotel
    attr_reader :reservations
    attr_accessor :rooms

    def initialize(rooms: [], reservations: [])
      @rooms = rooms
      @reservations = reservations
    end

    def add_room(room)
      @rooms << room
    end

    def list_rooms
      # Evaluates length first, skips .map method if there is no room
      return nil if rooms.length == 0
      all_rooms = @rooms.map {|room| room.room_num}
      return all_rooms
    end

    def new_reservation(room, checkin_date, checkout_date)
      # Based on Trip#connect on RideShare where we add trip to both passenger & driver
      reservation = BookingSystem::Reservation.new(room: room, checkin_date: checkin_date, checkout_date: checkout_date)
      # Adds new reservation to Hotel's array of reservations
      @reservations << reservation
      # Adds new reservation to Room's array of reservations
      room.add_reservation(reservation)
    end

    def list_by_date(date)
      matching_reservations = @reservations.select {|reservation| reservation.date_range.include?(date)}
      return matching_reservations
    end
  end
end