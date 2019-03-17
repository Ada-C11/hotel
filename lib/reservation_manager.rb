require_relative "reservation.rb"
require "date"
require "pry"
require "awesome_print"

module Hotel
  class ReservationManager
    #add constant for room numbers
    MAX_ROOMS = 20

    def initialize
      @reservations = []
      @block = []
    end

    def all_rooms
      rooms = (1..MAX_ROOMS).to_a
      return rooms
    end

    def make_reservation(check_in, check_out)
      # unsure how to raise argument error when room is unavailable since room_number is assigned from avail_rooms array
      if available_rooms(check_in, check_out).length == 0
        raise ArgumentError, "There are no available rooms for this time period"
      else
        room_number = available_rooms(check_in, check_out).first
        new_reservation = Hotel::Reservation.new(room_number,
                                                 check_in,
                                                 check_out)

        # @reservations << new_reservation
      end
      @reservations << new_reservation

      return new_reservation
    end

    def reservations_by_date(start_date, end_date)
      s_date = Date.parse(start_date)
      e_date = Date.parse(end_date)
      reservations_by_date = []
      @reservations.each do |reservation|
        if e_date > reservation.check_in && e_date <= reservation.check_out
          reservations_by_date << reservation
        elsif s_date >= reservation.check_in && s_date < reservation.check_out
          reservations_by_date << reservation
        elsif s_date <= reservation.check_in && e_date >= reservation.check_out
          reservations_by_date << reservation

          #Right now checkout day is not included because you can check-in on that day
        end
      end

      return reservations_by_date
    end

    def blocked_rm_by_date(start_date, end_date)
      s_date = Date.parse(start_date)
      e_date = Date.parse(end_date)
      blocks_by_date = []
      @block.each do |room|
        if e_date > room.check_in && e_date <= room.check_out
          blocks_by_date << room
        elsif s_date >= room.check_in && s_date < room.check_out
          blocks_by_date << room
        elsif s_date <= room.check_in && e_date >= room.check_out
          blocks_by_date << room

          #Right now checkout day is not included because you can check-in on that day
        end
      end

      return blocks_by_date
    end

    def available_rooms(start_date, end_date)
      unavail_rooms = reservations_by_date(start_date, end_date).map do |reservation|
        reservation.room_number
      end

      unavail_block_rms = blocked_rm_by_date(start_date, end_date).map do |block_room|
        block_room.room_number
      end

      all_unavail_rooms = unavail_rooms + unavail_block_rms
      # ap all_unavail_rooms

      all_avail_rooms = all_rooms.reject { |rm_num| all_unavail_rooms.include? rm_num }

      # ap all_avail_rooms

      return all_avail_rooms
    end

    def make_block(total_rooms_in_block, check_in, check_out, block_id)
      room_num_assign = available_rooms(check_in, check_out).take(total_rooms_in_block)

      room_num_assign.each do |room|
        room_number = room

        block_reservation = Hotel::Reservation.new(room_number,
                                                   check_in,
                                                   check_out, block_id)

        @block << block_reservation
        # return block_reservation

      end
      return @block

      # list_numbers = []
      # @block.each do |block_res|
      #   num = block_res.room_number
      #   list_numbers << num
      # end
      # return list_numbers
      ap @block
    end
  end
end
