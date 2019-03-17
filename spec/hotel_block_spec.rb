require 'date'
require_relative 'spec_helper'

describe "hotel_block class" do
  before do
    @hotel = Booking::Hotel_Manager.new(8)
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)
    @block = Booking::Block.new(@checkin_date, @checkout_date, [1,3,4,5], 150, hotel: @hotel)
  end
  
  it "creates a hotel_block" do
   expect(@block).must_be_kind_of Booking::Block
   expect(@block.requested_rooms).must_be_kind_of Array
   expect(@block.requested_rooms[1]).must_be_kind_of Integer
  end

  it "removes the block rooms from available_rooms array" do
    expect(@block.available_rooms[0]).wont_equal 1
  end

  it "raises an error if at least one of the selected rooms is unavailable" do
    @checkin_date2 = Date.new(2019,1,4)
    @checkout_date2 = Date.new(2019,1,7)
    @reservation = @block.hotel.add_reservation(@checkin_date, @checkout_date)
    expect{@block2 = Booking::Block.new(@checkin_date2, @checkout_date2, [1,3,4], 150, hotel: @hotel)}.must_raise ArgumentError
  end


  it "raises an error if I try to create another block with a room already in another block" do
    @checkin_date3 = Date.new(2019,1,4)
    @checkout_date3 = Date.new(2019,1,7)
    expect{@block3 = Booking::Block.new(@checkin_date3, @checkout_date3, [2,3], 150, hotel: @hotel)}.must_raise ArgumentError
  end

end

# end

describe "check_block_availability method" do 
  before do 
    @hotel = Booking::Hotel_Manager.new(8)
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)

    @checkin_date2 = Date.new(2019,1,5)
    @checkout_date2 = Date.new(2019,1,8)

    @block = Booking::Block.new(@checkin_date, @checkout_date, [1,3,4,5], 150, hotel: @hotel)
    @block2 = Booking::Block.new(@checkin_date2, @checkout_date2, [6,7,8], 150, hotel: @hotel)

    available = @hotel.check_availability(@checkin_date, @checkout_date)
  end

  it "can show available rooms in the block" do
    available = @block.block_availability(@block)
  end

end

describe "reserve room from block method" do
  before do 
    @hotel = Booking::Hotel_Manager.new(8)
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)

    @checkin_date2 = Date.new(2019,1,5)
    @checkout_date2 = Date.new(2019,1,8)

    @block = Booking::Block.new(@checkin_date, @checkout_date, [1,3,4,5], 150, hotel: @hotel)
    @reservation = @block.reserve_room(3)
  end
  
  it "can reserve a specific room from the block" do
    
    expect(@reservation).must_be_kind_of Booking::Reservation
  end

  it "can add that reservation to the hotel's list of reservations" do
    print @block.all_reservations
  end
end
