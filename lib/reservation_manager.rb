require_relative "reservation"
require "pry"

module Hotel
  class ReservationManager
    attr_reader :reservation_array, :rooms, :block_name

    def initialize
      @booked_rooms = []
      @available_rooms = []
      @reservation_array = []
      @blocked_rooms_array = []
      @blocked_reservation_array = []
      @rooms = ("1".."20").to_a
    end

    def make_reservation(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s, room: "0", cost: 200, block_name: "no name")
      new_reservation = Reservation.new(start_date: start_date, end_date: end_date, room: room, cost: cost, block_name: block_name)
      check_res = view_available_rooms(start_date: new_reservation.start_date, end_date: new_reservation.end_date)
      if !check_res.include?(new_reservation.room)
        raise ArgumentError, "That room is not available, choose another room"
      elsif new_reservation.block_name != "no name"
        raise ArgumentError, "Use the make_block_reservation method to reserve a room from a block"
      else
        @reservation_array << new_reservation
      end
      return new_reservation
    end

    def make_block_reservation(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s, room: "0", cost: 200, block_name: "hotel block")
      new_reservation = Reservation.new(start_date: start_date, end_date: end_date, room: room, cost: cost, block_name: block_name)

      @blocked_reservation_array.each do |blocked_res|
        if blocked_res.reservation_dates == new_reservation.reservation_dates && blocked_res.block_name == new_reservation.block_name
        elsif blocked_res.reservation_dates != new_reservation.reservation_dates && blocked_res.block_name == new_reservation.block_name
          raise ArgumentError, "You must reserve a blocked hotel room for its entire duration"
        end
      end

      res_to_remove = []
      @blocked_reservation_array.each do |blocked_res|
        if blocked_res.room == new_reservation.room
          res_to_remove << blocked_res
        end
      end
      @reservation_array << new_reservation
      @blocked_reservation_array.delete(res_to_remove[0])
      @blocked_rooms_array.delete(res_to_remove[0].room)

      return new_reservation
    end

    def hotel_block(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s, cost: 100, rooms_array: ["0"], block_name: "block name")
      start_date = start_date
      end_date = end_date
      cost = cost
      block_name = block_name
      rooms_array = rooms_array
      duration = (Date.parse(start_date)..Date.parse(end_date)).to_a

      rooms_array.each do |room|
        @reservation_array.each do |reservation|
          reservation.reservation_dates[0..-2].each do |date|
            if duration[0..-2].include?(date) && reservation.room.include?(room)
              raise ArgumentError, "A room in your desired block is booked during that time period"
            end
          end
        end

        @blocked_reservation_array.each do |blocked_reservation|
          blocked_reservation.reservation_dates[0..-2].each do |date|
            if duration[0..-2].include?(date) && blocked_reservation.room.include?(room)
              raise ArgumentError, "There is already a block on that date or room during your block duration."
            end
          end
        end
      end

      rooms_array.each do |block_room|
        block_reservation = Reservation.new(start_date: start_date, end_date: end_date, room: block_room, cost: cost, block_name: block_name)
        @blocked_rooms_array << block_reservation.room
        @blocked_reservation_array << block_reservation
        # binding.pry
      end

      return @blocked_rooms_array
    end

    def view_block_availability(block_name_input)
      specific_block_array = []

      @blocked_reservation_array.each do |blocked_res|
        if blocked_res.block_name == block_name_input && !@reservation_array.include?(blocked_res)
          # binding.pry
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
      @reservation_array.each do |reservation|
        if reservation.reservation_dates.include?(parsed_date)
          reservations_matching_date << reservation
        end
      end
      return reservations_matching_date
    end

    def view_available_rooms(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      date_range = (start_date..end_date).to_a

      # check for rooms not reserved
      # no specifications given if this method should show blocked rooms or not. I chose for it to show blocked rooms as available, since they have not been booked yet.
      date_range[0..-2].each do |date|
        @reservation_array.each do |reservation|
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
