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
          res_on_date << this_rooms_reservations unless this_rooms_reservations == nil
        end
      end

      return res_on_date # array with [[1, "2019-06-10 through 2019-06-12"], [room_num, "date through date"], etc]
    end

    def ck_avail(ckin, ckout, room_num)
      # check if specific room is available for this date range
      # return true/false
      raise ArgumentError, "This room number does not exist." if @rooms_reservations_hash.has_key?(room_num) == false

      res_array_to_check = @rooms_reservations_hash[room_num]

      res_0 = res_array_to_check[0]
      res_last = res_array_to_check.last

      if res_array_to_check.length == 0
        return true
      elsif res_array_to_check.length == 1
        (res_0.ckout_date <= ckin) || (ckout <= res_0.ckin_date) ? true : false
      else # there is more than one reservation in the array
        # check left and right ends of the reservation array
        return true if (ckout <= res_0.ckin_date)
        return true if (res_last.ckout_date <= ckin)
        # check date gaps between reservations
        i = 0
        while i <= res_array_to_check.length - 2
          res_a = res_array_to_check[i]
          res_b = res_array_to_check[i + 1]

          if (res_a.ckout_date <= ckin) && (ckout <= res_b.ckin_date)
            return true
          end

          i += 1
        end
        return false
      end
    end

    def find_avail_rooms_for_dates(ckin, ckout)
      avail_rooms = []
      puts "find_avail_rooms_for_dates, rooms_res_hash is:"
      p @rooms_reservations_hash

      @rooms_reservations_hash.each do |room_num, reservations|
        avail_rooms << room_num if reservations.empty?
        reservations.each do |res|
          avail_rooms << room_num if (ck_avail(ckin, ckout, room_num) && !avail_rooms.include?(room_num))
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

    def get_insert_index(res_array, new_res)
      insert_index = 0
      res_array.each do |res_in_array|
        if (res_in_array.ckin_date <=> new_res.ckin_date) == -1
          insert_index += 1
        end
      end

      return insert_index
    end

    def make_res_for_room(ckin, ckout, room_num)
      raise ArgumentError, "This room is not available on the dates entered." unless ck_avail(ckin, ckout, room_num)

      new_res = Reservation.new(ckin, ckout)
      at_index = get_insert_index(@rooms_reservations_hash[room_num], new_res)
      @rooms_reservations_hash[room_num].insert(at_index, new_res)
    end
  end
end
