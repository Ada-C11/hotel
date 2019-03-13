require "date"
require "pry"

module Hotel
  class Frontdesk
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = Frontdesk.all_rooms
      @reservations = []
    end

    def request_reservation(name, checkin_date, num_of_nights)
      reservation = Hotel::Reservation.new(name, checkin_date, num_of_nights)
      assign_room_number(reservation)
      @reservations << reservation
      return reservation
    end

    def find_available_rooms(dates)
      available_rooms = []
      @rooms.each do |room|
        overlap = room.availability & dates
        if overlap.length == 0
          available_rooms << room
        end
      end
      if available_rooms.length == 0
        raise ArgumentError, "There are no available rooms for that date"
      else
        return available_rooms
      end
    end

    def assign_room_number(reservation)
      available_rooms = find_available_rooms(reservation.reserved_nights)
      room_assignment = available_rooms.first
      reservation.room_num = room_assignment.number
      room_assignment.add_reservation(reservation)
    end

    def find_reservation_by_date(date)
      reservations_by_date = @reservations.find_all { |reservation| reservation.reserved_nights.include?(Date.parse(date)) }
      if reservations_by_date.length == 0
        return nil
      else
        return reservations_by_date
      end
    end

    private

    def self.all_rooms
      room_list = []
      counter = 0
      20.times do
        room = Room.new(counter + 1)
        counter += 1
        room_list << room
      end
      return room_list
    end
  end
end
