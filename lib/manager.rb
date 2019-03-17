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
      #   puts "Rooms in this hotel:"
      #   puts all_room_numbers
      return all_room_numbers
    end

    def list_reservations_for_date(date)
      res_on_date = []
      @rooms_reservations_hash.each do |room, reservations|
        reservations.each do |res|
          if res.date_range_string_array.include? (date.to_s)
            this_rooms_reservations = [room]
            this_rooms_reservations << (res.date_range_string_array.first + " through " + res.date_range_string_array.last)
          end
          res_on_date << this_rooms_reservations
        end
      end
      #   binding.pry
      return res_on_date #array with room and reservations
    end

    def find_avail_rooms_for_dates(ckin, ckout)
      avail_rooms = []

      @rooms_reservations_hash.each do |room, reservations|
        avail_rooms << room if reservations.empty?
        reservations.each_with_index do |res, index|
          res_a = res
          res_b = reservations[index + 1]
          if (res_a.ckout_date <= ckin) && (ckout <= res_b.ckin_date)
            # binding.pry
            avail_rooms << room
          end
        end
      end
      return avail_rooms
    end

    def print_available_rooms_for_dates(ckin, ckout)
      # This method is a helper to print the results of #find_avail_rooms_for_dates(ckin, ckout)
      avail_rooms = find_avail_rooms_for_dates(ckin, ckout)
      puts "Rooms available #{ckin.strftime("%-m/%-d/%y")} - #{ckout.strftime("%-m/%-d/%y")}"
      puts avail_rooms
      return avail_rooms
    end

    def get_insert_index(res_hash, new_res)
      insert_index = 0

      res_hash.each do |res_in_hash|
        # DOES IT MAKE SENSE TO KEEP THIS IN ITS OWN METHOD?
        # IF NOT, MOVE TO #make_res_for_room
        if (res_in_hash.ckin_date <=> new_res.ckin_date) == -1
          insert_index += 1
        end
      end

      return insert_index
    end

    def ck_avail(ckin, ckout, room_num)
      # DO WE NEED THIS METHOD? MAYBE NOT.
      # check if specific room is available for this date range
      # return true/false
    end

    def make_res_for_room(ckin, ckout, room_num)
      # ck_avail
      # if true, continue; else return error
      new_res = Reservation.new(ckin, ckout)
      at_index = get_insert_index(@rooms_reservations_hash[room_num], new_res)
      @rooms_reservations_hash[room_num].insert(at_index, new_res)

      #   binding.pry
    end
  end
end
