require "pry"
require_relative "room"

module Hotel
  class Manager
    attr_accessor :rooms_reservations_hash

    def initialize
      @rooms_reservations_hash = Room.make_rooms
    end

    # Manager.rooms_res_hash builds this structure:
    # {
    #     1:[],
    #     2:[],
    #     3:[],
    #     4:[]
    #      ...
    #     20:[]
    # }

    def list_rooms
      all_room_numbers = @rooms_reservations_hash.keys.sort!

      puts "Rooms in this hotel:"
      puts all_room_numbers

      return all_room_numbers
    end

    def list_reservations_for_date(date)
      res_on_date = []  # write code here
      @rooms_reservations_hash.each do |room, reservations|
        reservations.each do |res|
          if res.date_range_string_array.include? (date.to_s)
            this_rooms_reservations = [room]
            this_rooms_reservations << res.date_range_string_array
          end
          res_on_date << this_rooms_reservations
        end
      end

      return res_on_date #array with room and reservations
      binding.pry
    end

    def find_avail_rooms_for_dates(ckin, ckout)
      # write code here
    end

    def make_res_for_room(ckin, ckout, room_num)
      new_res = Reservation.new(ckin, ckout)

      @rooms_reservations_hash[room_num] << new_res
      #   binding.pry
    end
  end
end
