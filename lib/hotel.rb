require_relative 'room'
require_relative 'reservation'

NUM_OF_ROOMS = 20

module BookingSystem
  class Hotel
    attr_reader :reservations
    attr_accessor :rooms

    def initialize(rooms: [], reservations: [])
      # Rooms instantiation is now handled by Room, single responsibility principle
      @rooms = BookingSystem::Room.make_rooms(rooms)
      @reservations = reservations
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

    def is_valid?(tentative_in, tentative_out)
      return true if tentative_in >= checkout_date
      if tentative_in < checkin_date
        return true if tentative_out <= checkin_date
      else return false
      end
    end

    def list_available_rooms(tentative_in, tentative_out)
      raise ArgumentError.new("You haven't added any room to our hotel :/") if rooms.length == 0
      available rooms = @rooms.select {|room| self.is_valid?(tentative_in, tentative_out)}
      if available_rooms.length == 0
        raise ArgumentError.new("There is no available room")
      else
        return available_rooms
      end
    end
  end
end