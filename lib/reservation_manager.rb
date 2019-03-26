require "time"
require "date"

require_relative "reservation.rb"
require_relative "room.rb"
require_relative "block.rb"
require_relative "helpers.rb"

module Hotel
  class Reservation_Manager
    attr_accessor :rooms, :reservations, :blocks

    ROOM_IDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    ROOM_COST = 200.0

    def initialize
      @rooms = upload_rooms
      @blocks = []
    end

    # pushes constant variables into array, linking with room id
    def upload_rooms
      rooms = []
      ROOM_IDS.each do |id|
        room = Room.new(id)
        rooms << room
      end

      return rooms
    end

    def see_rooms
      return @rooms
    end

    def reserve_room(input)
      Hotel::Helpers.find_all_avail_rooms(input[:check_in_date], input[:check_out_date])

      reserve = { name: input[:name],
                 room_number: input[:room_id],
                 check_in_date: input[:check_in_date],
                 check_out_date: input[:check_out_date] }
      reservation = Hotel::Reservation.new(reserve)
      Hotel::Helpers.link_room_id_with_reservation_id(@rooms, input[:room_id], reservation)
    end

    def list_reservations(date)
      reservations = []
      @rooms.each do |room|
        index = Hotel::Helpers.sort_by_date(room.reservations, date)
        if index == nil
          next
        elsif reservations << room.reservations[index]
        end
      end
      if reservations.empty?
        return raise StandardError, "There are no rooms reserved on the requested date."
      else
        return reservations
      end
    end
  end
end
