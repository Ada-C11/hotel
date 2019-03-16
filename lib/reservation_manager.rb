require_relative "reservation.rb"
require "date"
require "pry"

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

    def available_rooms(start_date, end_date)
      unavail_rooms = reservations_by_date(start_date, end_date).map do |reservation|
        reservation.room_number
      end

      non_block_avail_rooms = all_rooms.reject { |rm_num| unavail_rooms.include? rm_num }

      #if you want to remove line below, change non_block_avail_rooms to avail_rooms

      avail_rooms = non_block_avail_rooms.reject { |rm_num| @block.include? rm_num }

      return avail_rooms
    end

    def make_block(total_rooms_in_block, check_in, check_out)
      # room_number = available_rooms(check_in, check_out).first
      block_room_numbers = available_rooms(check_in, check_out).take(total_rooms_in_block)

      block_room_numbers.each do |room|
        room_number = room
        # room_number = available_rooms(check_in, check_out).sample
        block_reservation = Hotel::Reservation.new(room_number,
                                                   check_in,
                                                   check_out)

        @block << block_reservation.room_number
      end

      return @block
    end

    # def reserve_block(start_date, end_date)
    #   s_date = Date.parse(start_date)
    #   e_date = Date.parse(end_date)
    #   reservations_by_date = []
    #   @reservations.each do |reservation|
    #     if e_date > reservation.check_in && e_date <= reservation.check_out
    #       reservations_by_date << reservation
    #     elsif s_date >= reservation.check_in && s_date < reservation.check_out
    #       reservations_by_date << reservation
    #     elsif s_date <= reservation.check_in && e_date >= reservation.check_out
    #       reservations_by_date << reservation
    # end
  end
end
