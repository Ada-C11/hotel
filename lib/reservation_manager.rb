require 'date'

module Hotel
  class ReservationManager
    attr_reader :reservations, :block_reservations

    def initialize
      @reservations = []
      @block_reservations = []
    end

    def hotel_rooms
      rooms = [*1..20]
      return rooms 
    end

    #  basic reservation methods
    def book_reservation(room, date_range)
      unless room_availability(date_range.check_in, date_range.check_out).include?(room)
        raise ArgumentError, "The room you've selected is not available for these dates."
      end
      reservation = Hotel::Reservation.new(room, date_range)
      @reservations << reservation
      return reservation
    end

    # checks each reservation by date and adds it to the reservations list
    def res_by_date(date)
      booked_reservations = @reservations.find_all do |reservation|
        reservation.date_range.date_check(date)
      end
        if booked_reservations.empty?
          return []
        else
          return booked_reservations
        end
    end

    # check if a date range has been taken and store it in booked rooms array
    def room_availability(check_in, check_out)
      booked_rooms = []
      @reservations.each do |reservation|
        if reservation.date_range.dates_overlap?(check_in, check_out)
          booked_rooms << reservation.room
        end
      end
    # check date overlaps for blocks
      @block_reservations.each do |block|
        if block.date_range.dates_overlap?(check_in, check_out)
          booked_rooms << block.room
        end
      end
      # available frooms minus already booked rooms
      return hotel_rooms - booked_rooms
    end

    # block reservation methods
    def make_block_res(rooms, date_range, cost = 100)
      hotel_block = Hotel::HotelBlock.new(rooms, date_range, cost)
      @block_reservations << hotel_block
      return hotel_block
    end

    def find_block_by_date(date_range)
      block_match = @block_reservations.find do |hotel_block|
        hotel_block.block_date_check(date_range)
      end
      return block_match
    end

    def reserve_block(room, date_range)
      hotel_block = find_block_by_date(date_range)
      hotel_block.book_block_reservation(room, date_range)
    end 

  end
end 
