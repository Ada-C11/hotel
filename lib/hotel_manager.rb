require 'date'
require 'pry'

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

    
    def add_reservation(room, checkin_date, checkout_date)

      unless @all_rooms.include?(room)
        raise ArgumentError, "There is no room #{room} available"
      end

      unless check_availability(checkin_date, checkout_date).include?(room)
        raise ArgumentError, "That room is already reserved"
      end
  
      reservation = Hotel::Reservation.new((room, checkin_date, checkout_date)
      @all_reservations << reservation

      return reservation
    end

    def reservations_by_date(date)
      @all_reservations.select {|reservation| reservation.contains(date)}
    end

    def check_availability(checkin_date, checkout_date)

      dates = Date_Range.new(checkin_date, checkout_date)
      available_rooms = @all_rooms

      overlapping_blocks = @blocks.select do |block|
        block.overlaps(dates)
      end

      blocked_rooms = overlapping_blocks.reduce([]) do |check, block|
        check += block.rooms
      end

      available_rooms -= blocked_rooms

      overlapping_rooms = @reservations.select do |reservation|
        reservation.overlaps(dates)
      end
      reserved_rooms = overlapping_rooms.map do |reservation|
        reservation.room
      end

      available_rooms -= reserved_rooms
      
      return available_rooms
    end
    
# END OF CLASS
  end
# END OF MODULE
end

