NUM_OF_ROOMS = 20

module BookingSystem
  class Hotel
    attr_reader :reservations
    attr_accessor :rooms

    def initialize(rooms: [], reservations: [])
      @rooms = BookingSystem::Room.make_rooms(rooms)
      @reservations = reservations
    end

    def add_room(room)
      @rooms << room
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    # Rework this into separate class
    def new_reservation(room, checkin_date, checkout_date)
      (checkin_date...checkout_date).each do |day|
        if !room.is_available?(day)
          raise ArgumentError.new("Room#{room_num} is not available")
        end
      end
      reservation = BookingSystem::Reservation.new(room: room, checkin_date: checkin_date, checkout_date: checkout_date)
      add_reservation(reservation)
      room.add_reservation(reservation)
    end

    def list_all_rooms
      return rooms if rooms.length == 0
      return @rooms.map {|room| room.room_num}
    end

    def list_by_date(date)
      return reservations if reservations.length == 0
      return @reservations.select {|reservation| reservation.date_range.include?(date)}
    end

    def list_available_rooms(tentative_in, tentative_out)
      raise ArgumentError.new("There is no room instantiated in our hotel") if rooms.length == 0
      available_rooms = @rooms
      (tentative_in...tentative_out).each do |day|
        available_rooms.select! {|room| room.is_available?(day)}
      end
      if available_rooms.length == 0
        raise ArgumentError.new("There is no available room")
      else
        return available_rooms
      end
    end
  end
end