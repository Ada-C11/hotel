require_relative "room.rb"
require_relative "reservation.rb"

module Hotel
  class Hotel_manager
    ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    attr_reader :rooms, :reservations

    def initialize
      @rooms = ROOM_NUMBERS.map do |number|
        Hotel::Room.new(number)
      end
      @reservations = []
    end

    def make_reservation(room_number, start_date, end_date)
      room = find_room_by_number(room_number)
      if self.list_available_rooms(start_date, end_date).include?(room)
        new_reservation = Hotel::Reservation.new(room: room, start_date: start_date, end_date: end_date)
        @reservations.push(new_reservation)
        return new_reservation
      else
        raise ArgumentError, "Room #{room_number} is unavailable. Must use an available room."
      end
    end

    def list_reservations_by_date(date)
      date = Date.parse(date)
      found_reservations = []
      @reservations.each do |reservation|
        if date >= reservation.start_date && date < reservation.end_date
          found_reservations.push(reservation)
        end
      end
      return found_reservations
    end

    def list_available_rooms(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      available_rooms = @rooms
      reservations.each do |reservation|
        if reservation.start_date >= start_date && reservation.end_date <= end_date
          available_rooms.delete(reservation.room)
        end
      end
      return available_rooms
    end

    def find_room_by_number(num)
      @rooms.each do |room|
        return room if room.room_number == num
      end
    end
  end
end
