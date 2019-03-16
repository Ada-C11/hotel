require_relative "room.rb"
require_relative "reservation.rb"

module Hotel
  class HotelManager
    attr_reader :rooms, :reservations

    def initialize(rooms)
      @rooms = rooms
      @reservations = []
      @blocks = []
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
      start_date, end_date = parse_dates(start_date, end_date)
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

    private

    def self.validate_rooms(rooms)
      unless rooms.length <= 5
        raise ArgumentError, "The max number of rooms for a block is 5."
      end
    end

    def parse_dates(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      return start_date, end_date
    end

    def self.validate_dates(start_date, end_date)
      unless end_date > start_date
        raise ArgumentError, "End date must be after start date"
      end
    end
  end
end
