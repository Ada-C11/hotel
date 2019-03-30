# Require gems
require "date"

# Require relatives
require_relative "room.rb"
require_relative "reservation.rb"

module Hotel
  class Manager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..20).map do |room_number|
        Hotel::Room.new(room_number: room_number)
      end

      @reservations = []
    end

    def reserve_room(check_in, check_out, room_selection: nil)
      available_room_list = list_available_rooms(check_in, check_out)

      if available_room_list == []
        return available_room_list
      elsif room_selection != nil
        available_room = ""
        available_room_list.each do |room|
          available_room = room if room.room_number == room_selection
        end
        if available_room == ""
          raise ArgumentError, "Room ##{room_selection} is unavailable between #{check_in} and #{check_out}."
        end
      else
        available_room = available_room_list[0]
      end

      reservation = Hotel::Reservation.new(
        check_in: check_in,
        check_out: check_out,
        room: available_room,
        id: @reservations.length + 1,
      )

      available_room.add_reservation(reservation)
      @reservations << reservation

      return reservation
    end

    def list_available_rooms(check_in, check_out)
      list = []
      booking_range = (Date.parse(check_in)..Date.parse(check_out))

      @rooms.each do |room|
        if room.is_available?(booking_range)
          list << room
        end
      end

      return list
    end

    def list_reservations_on(date)
      list = []
      date = Date.parse(date)

      @reservations.each do |reservation|
        check_in = reservation.check_in
        check_out = reservation.check_out

        if (check_in..check_out).include?(date)
          list << reservation
        end
      end

      return list
    end
  end
end
