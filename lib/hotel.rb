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

    # Possibly unneccessary?
    def new_reservation(room, checkin_date, checkout_date)
      reservation = BookingSystem::Reservation.new(room: room, checkin_date: checkin_date, checkout_date: checkout_date)
      return reservation
    end

    def book_new_reservation(room, checkin_date, checkout_date)
      (checkin_date...checkout_date).each do |day|
        raise ArgumentError.new("Room#{room_num} is not available") if room.is_available?(day) == false
      end
      reservation = new_reservation(room, checkin_date, checkout_date)
      add_reservation(reservation)
      room.add_reservation(reservation)
      return reservation
    end

    def list_by_date(date)
      return reservations if reservations.length == 0
      return @reservations.select {|reservation| reservation.date_range.include?(date)}
    end

    def list_available_rooms(tentative_in, tentative_out)
      # raise ArgumentError.new("There is no room instantiated in our hotel") if rooms.length == 0
      avail_rooms = @rooms
      (tentative_in...tentative_out).each do |day|
        avail_rooms.select! {|room| room.is_available?(day)}
      end
      if avail_rooms.length == 0
        raise ArgumentError.new("There is no available room")
      else
        return avail_rooms
      end
    end
  end
end