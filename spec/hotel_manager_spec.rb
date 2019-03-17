require 'date'

require_relative 'spec_helper'

describe "hotel_manager initalize" do 
  it "raises an error if a hotel has more than 20 rooms" do 
    expect {hotel = Booking::Hotel_Manager.new(21)}.must_raise ArgumentError
  end
end

describe "@all_rooms variable" do
  it "provides a list of all rooms in the hotel" do
    hotel = Booking::Hotel_Manager.new(5)

    expect(hotel.all_rooms).must_be_kind_of Array
    expect(hotel.all_rooms[4]).must_equal 5
    
  end
end

describe "add_reservation method" do
  before do
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)
    @hotel = Booking::Hotel_Manager.new(4)
    
    # @reservation = Booking::Reservation.new(2, @checkin_date, @checkout_date)
  end

  it "adds the Reservation to a list of reservations" do
    @hotel.add_reservation(@checkin_date, @checkout_date)
    expect(@hotel.all_reservations.length).must_equal 1
  end
end

describe "reservation_by_date" do 
  before do
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)
    @hotel = Booking::Hotel_Manager.new(4)
    
    # @reservation = Booking::Reservation.new(2, @checkin_date, @checkout_date)

    @checkin_date2 = Date.new(2019,1,4)
    @checkout_date2 = Date.new(2019,1,8)
    
    # @reservation2 = Booking::Reservation.new(2, @checkin_date, @checkout_date)
  end
  it "allows you to look up reservations by a specific date" do 
    @hotel.add_reservation(@checkin_date2, @checkout_date2)
    @hotel.add_reservation(@checkin_date, @checkout_date)

    check = @hotel.reservations_by_date(@checkin_date)
    expect(check[0]).must_be_kind_of Booking::Reservation
    expect(check.length).must_equal 2
    expect(check[0].checkin_date).must_equal @checkin_date
  end
end

describe "check_availability method" do
  before do
    @hotel = Booking::Hotel_Manager.new(3)
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)
    
    # @reservation = Booking::Reservation.new(@hotel.check_availability(@checkin_date, @checkout_date).first, @checkin_date, @checkout_date)

    
    @reservation = @hotel.add_reservation(@checkin_date, @checkout_date)

    @checkin_date2 = Date.new(2019,1,4)
    @checkout_date2 = Date.new(2019,1,7)
    
    # @reservation2 = Booking::Reservation.new(@hotel.check_availability(@checkin_date2, @checkout_date2).first, @checkin_date, @checkout_date)

    @reservation2 = @hotel.add_reservation(@checkin_date2, @checkout_date2)
  end

  it "checks if booked room number is included in array available rooms" do
    
    availability = @hotel.check_availability(@checkin_date, @checkout_date)
    
    expect(availability.length).must_equal 1
    expect(availability).wont_include 2
  end

  it "returns a list of available rooms" do
    availability = @hotel.check_availability(@checkin_date, @checkout_date)
    expect(availability).must_be_kind_of Array
  end

  it "expects that the room can't be double-booked" do 
    expect(@reservation.room_number).wont_equal @reservation2.room_number
  end

  it "raises an error if there are no available rooms for that date" do
    @checkin_date3 = Date.new(2019,1,4)
    @checkout_date3 = Date.new(2019,1,7)
    @reservation3 = @hotel.add_reservation(@checkin_date3, @checkout_date3)

    @checkin_date4 = Date.new(2019,1,4)
    @checkout_date4 = Date.new(2019,1,7)

    expect{@hotel.check_availability(@checkin_date4, @checkout_date4)}.must_raise ArgumentError
  end

  it "allows a room to be reserved on a previous reservation's checkout date" do
    @checkin_date5 = Date.new(2019,1,7)
    @checkout_date5 = Date.new(2019,1,9)

    @reservation5 = @hotel.add_reservation(@checkin_date5, @checkout_date5)
    expect(@reservation5).must_be_kind_of Booking::Reservation
  end
end

# describe "hotel_block method" do
#   before do
#     @hotel = Booking::Hotel.new(5)
#     @checkin_date = Date.new(2019,1,4)
#     @checkout_date = Date.new(2019,1,7)
#     @block = @hotel.hotel_block(@checkin_date, @checkout_date, [1,3,4,5], 150)
#   end

#   it "creates a hotel_block" do
#    expect(@block).must_be_kind_of Array
#    expect(@block.length).must_equal 4
#    expect(@block[1]).must_be_kind_of Booking::Room
#   end

#   it "removes the block rooms from available_rooms array" do
#     expect(@hotel.available_rooms[0]).wont_equal 1
#   end

#   it "raises an error if a block has more than 5 rooms" do
#     expect{@hotel.hotel_block(@checkin_date, @checkout_date, [1,2,3,4,5,6], 150)}.must_raise ArgumentError
#   end

#   it "raises an error if at least one of the selected rooms is unavailable" do
#     @hotel.add_reservation(@checkin_date, @checkout_date)
#     expect{@hotel.hotel_block(@checkin_date, @checkout_date, [1,3,4,5], 150)}.must_raise ArgumentError
#   end

#   it "raises an error if I try to create another block with a room already in another block" do
#     @checkin_date2 = Date.new(2019,1,6)
#     @checkout_date2 = Date.new(2019,1,9)
#     expect{@hotel.hotel_block(@checkin_date2, @checkout_date2, [6,7,8,3], 150)}.must_raise ArgumentError
#   end

# end

# describe "block_availability method" do 
#   before do 
#     @hotel = Booking::Hotel.new(8)

#     @checkin_date = Date.new(2019,1,4)
#     @checkout_date = Date.new(2019,1,7)

#     @checkin_date2 = Date.new(2019,1,5)
#     @checkout_date2 = Date.new(2019,1,8)

#     @block = @hotel.hotel_block(@checkin_date, @checkout_date, [1,3,4,5], 150)
#     @block2 = @hotel.hotel_block(@checkin_date2, @checkout_date2, [6,7,8], 150)
#   end

#   it "can list the available rooms in a block" do
#     @available_rooms = @hotel.block_availability(@block)
#     @available_rooms2 = @hotel.block_availability(@block2)

#     expect(@available_rooms).must_be_kind_of Array
#     expect(@available_rooms[0]).must_equal 1

#     expect(@available_rooms2.length).must_equal 3
#     expect(@available_rooms2[0]).must_equal 6
#   end
# # END OF DESCRIBE
# end

# describe "reserve_room_from_block" do
#   before do
#     @hotel = Booking::Hotel.new(8)
#     @checkin_date = Date.new(2019,1,4)
#     @checkout_date = Date.new(2019,1,7)
#     @block = @hotel.hotel_block(@checkin_date, @checkout_date, [1,3,4,5], 150)
#   end

#   it "can reserve a room from the block" do
    
#     @reservation = @hotel.reserve_room_from_block(@block, 3)
    
#   expect(@reservation).must_be_kind_of Booking::Reservation
    
#   end

# end

