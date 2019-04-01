
require_relative "reservation"
require "pry"

module Hotel
  class ReservationManager
    attr_reader :all_reservations, :rooms, :blocked_reservations

    def initialize
      @booked_rooms = []
      @available_rooms = []
      @all_reservations = []
      @blocked_reservations = []
      @rooms = ("1".."20").to_a
    end

    def make_reservation(start_date, end_date, room: "0", cost: 200, block_name: nil)
      new_reservation = Reservation.new(start_date, end_date, room: room, cost: cost, block_name: block_name)
      check_res = view_available_rooms(new_reservation.start_date, new_reservation.end_date)
      if !check_res.include?(new_reservation.room)
        raise ArgumentError, "That room is not available, choose another room"
      elsif new_reservation.block_name != nil
        raise ArgumentError, "Use the make_block_reservation method to reserve a room from a block"
      else
        @all_reservations << new_reservation
      end
      return new_reservation
    end

    def hotel_block(start_date, end_date, rooms_array: ["0"], cost: 100, block_name: "block name")
      start_date = start_date
      end_date = end_date
      cost = cost
      block_name = block_name
      rooms_array = rooms_array
      duration = (Date.parse(start_date)..Date.parse(end_date)).to_a

      rooms_array.each do |room|
        @all_reservations.each do |reservation|
          reservation.reservation_dates[0..-2].each do |date|
            if duration[0..-2].include?(date) && reservation.room.include?(room)
              raise ArgumentError, "A room in your desired block is booked during that time period"
            end
          end
        end

        @blocked_reservations.each do |blocked_reservation|
          blocked_reservation.reservation_dates[0..-2].each do |date|
            if duration[0..-2].include?(date) && blocked_reservation.room.include?(room)
              raise ArgumentError, "There is already a block on that date or room during your block duration."
            end
          end
        end
      end

      rooms_array.each do |block_room|
        block_reservation = Reservation.new(start_date, end_date, room: block_room, cost: cost, block_name: block_name)

        @blocked_reservations << block_reservation
      end

      return blocked_reservations
    end

    def make_block_reservation(start_date, end_date, room: "0", cost: 200, block_name: nil)
      new_reservation = Reservation.new(start_date, end_date, room: room, cost: cost, block_name: block_name)

      @blocked_reservations.each do |blocked_res|
        if blocked_res.reservation_dates != new_reservation.reservation_dates && blocked_res.block_name == new_reservation.block_name
          raise ArgumentError, "You must reserve a blocked hotel room for its entire duration"
        end
      end

      @all_reservations << new_reservation

      @blocked_reservations.each do |blocked_res|
        if blocked_res.room == new_reservation.room
          @blocked_reservations.delete(blocked_res)
        end
      end

      return new_reservation
    end

    def view_block_availability(block_name_input)
      specific_block_array = []

      @blocked_reservations.each do |blocked_res|
        if blocked_res.block_name == block_name_input && !@all_reservations.include?(blocked_res)
          specific_block_array << blocked_res
        end
      end
      return specific_block_array
    end

    def view_all_rooms
      return @rooms
    end

    def access_reservations_by_date(date)
      parsed_date = Date.parse(date)
      reservations_matching_date = []
      @all_reservations.each do |reservation|
        if reservation.reservation_dates.include?(parsed_date)
          reservations_matching_date << reservation
        end
      end
      return reservations_matching_date
    end

    def view_available_rooms(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      date_range = (start_date..end_date).to_a

      date_range[0..-2].each do |date|
        @all_reservations.each do |reservation|
          if reservation.reservation_dates[0..-2].include?(date)
            @booked_rooms << reservation.room
          end
        end
      end

      @available_rooms = rooms - @booked_rooms
      return @available_rooms
    end
  end
end
