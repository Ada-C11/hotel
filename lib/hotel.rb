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

    def list_all_rooms
      # Evaluates length first, bypasses .map method if there is no room
      return rooms if rooms.length == 0
      return @rooms.map {|room| room.room_num}
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def new_reservation(room, checkin_date, checkout_date)
      reservation = BookingSystem::Reservation.new(room: room, checkin_date: checkin_date, checkout_date: checkout_date)
      add_reservation(reservation)
      room.add_reservation(reservation)
    end

    def list_by_date(date)
      return reservations if reservations.length == 0
      return @reservations.select {|reservation| reservation.date_range.include?(date)}
    end

    def overlap?(date)
      reservations.each do |reservation|
        reservation.date_range.each do |res_date|
          return true if date == res_date
        end
      end
      return false
    end

    # Rewrite this
    def list_available_rooms(date)
      raise ArgumentError.new("There is no room") if rooms.length == 0
      available_rooms = @rooms.select {|room| self.reserved?(date)}
      if available_rooms.length == 0
        raise ArgumentError.new("There is no available room")
      else
        return available_rooms
      end
    end
  end
end