require 'date'
require 'pry'
require_relative 'reservation'

module Hotel
  class Hotel_Manager
    attr_reader :all_reservations, :all_rooms, :available_rooms, :all_blocks

    def initialize(max_rooms)
      if max_rooms > 20
        raise ArgumentError, "Hotel can have 20 rooms max"
      else
        @all_rooms = [*1..max_rooms]
      end
      @room_rate = 200
      @all_reservations = []
      @available_rooms = []
      @all_blocks = [] 
    end

    # add a reservation to the reservations array
    def add_reservation(room, checkin_date, checkout_date)

      unless @all_rooms.include?(room)
        raise ArgumentError, "There is no room #{room} available"
      end

      unless check_availability(checkin_date, checkout_date).include?(room)
        raise ArgumentError, "That room is already reserved"
      end
  
      reservation = Hotel::Reservation.new(room, checkin_date, checkout_date, @room_rate)
      @all_reservations << reservation

      return reservation
    end

    # list reservations by date
    def reservations_by_date(date)
      @all_reservations.select {|reservation| reservation.contains(date)}
    end

    # availability of rooms
    def check_availability(checkin_date, checkout_date)

      dates = Date_Range.new(checkin_date, checkout_date)
      available_rooms = @all_rooms

      overlapping_blocks = @all_blocks.select do |block|
        block.overlaps(dates)
      end

      blocked_rooms = overlapping_blocks.reduce([]) do |check, block|
        check += block.rooms
      end

      available_rooms -= blocked_rooms

      overlapping_rooms = @all_reservations.select do |reservation|
        reservation.overlaps(dates)
      end
      reserved_rooms = overlapping_rooms.map do |reservation|
        reservation.room_number
      end

      available_rooms -= reserved_rooms

      if available_rooms.empty?
        raise ArgumentError, "There are no available rooms."
      end
      
      return available_rooms
    end

    def create_block(requested_rooms, checkin_date, checkout_date, discounted_rate)
      rooms = available_rooms(checkin_date, checkout_date)
      if rooms.length < requested_rooms
        raise ArgumentError, "There aren't enough rooms available"
      end

      block = Block.new(rooms.first(requested_rooms), checkin_date, checkout_date)
      @blocks << block
      return block
    end

      def reserve_from_block(block)
        room = block.reserve_room
        reservation = Reservation.new(room, block.checkin_date, block.checkout_date, block.discounted_rate)
        @all_reservations << reservation
        return reservation
      end
      
# END OF CLASS
  end
# END OF MODULE
end

