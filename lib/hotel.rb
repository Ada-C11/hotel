require_relative "spec_helper"
require "reservation"
require "date_range"

class Hotel
    attr_accessor :reservations, :rooms 

    def initialize
        @rooms = new_rooms(20)
        @reservations = []
        @block_reservations = {}
    end
end

    def find_available_rooms(dates)
        available_rooms = []
        @rooms.each do |room|
        overlap = room.availability & dates
        if overlap.length == 0
        available_rooms << room
        end
    end
    return available_rooms
  end

    def assign_room_number(reservation)
        available_rooms = find_available_rooms(reservation.reserved_nights)
        if available_rooms.length == 0
        raise ArgumentError, "There are no available rooms for those dates."
    else
        room_assignment = available_rooms.first
        reservation.room_num = room_assignment.number
        room_assignment.add_reservation(reservation)
    end
  end

  def find_reservation_by_date(date)
    reservations_by_date = @reservations.find_all { |reservation| reservation.reserved_nights.include?(Date.parse(date)) }
  end

  def find_reservation_by_date(date)
    reservations_by_date = @reservations.find_all { |reservation| reservation.reserved_nights.include?(Date.parse(date)) }
  end

  def initialize(name, check_in, total_nights)
    @name = name
    @check_in = Date.parse(check_in)

    if total_nights >= 1
      @total_nights = total_nights
    else 
      raise ArgumentError, "Please reserve at least one night."
    end
  
    @check_out = @check_in + total_nights
    @reserved_dates = total_reserved_nights
    @room_number = nil
  end






# def calculate_total_cost()
#   total_nights = @end_date - @start_date - 1 #probably convert to integer after test
#   @room_price * total_nights
# end

# describe Hotel do
#     it "creates a list of 20 rooms" do 
#         (@hotel.rooms.length).must_equal 20
#         (@hotel.rooms).must_be_instance_of Array
#     end
# end