require 'date'
require_relative 'spec_helper'

# describe "hotel_block class" do
#   before do
#     @hotel = Hotel::Hotel_Manager.new(5)
#     @checkin_date = Date.new(2019,1,4)
#     @checkout_date = Date.new(2019,1,7)
#     @block = Hotel::Block.new([1,3,4,5], @checkin_date, @checkout_date, 150)
#   end
  
#   it "creates a hotel_block" do
#    expect(@block).must_be_kind_of Hotel::Block
#    expect(@block.requested_rooms).must_be_kind_of Array
#    expect(@block.requested_rooms[1]).must_be_kind_of Integer
#   end

#   # it "removes the block rooms from available_rooms array" do
#   #   expect(@block.available_rooms).wont_include 1
#   # end

#   it "raises an error if at least one of the selected rooms is unavailable" do
#     @checkin_date2 = Date.new(2019,1,4)
#     @checkout_date2 = Date.new(2019,1,7)
#     # @reservation = @block.add_reservation(1,@checkin_date, @checkout_date)
#     expect{@block2 = Hotel::Block.new([2,3,4], @checkin_date2, @checkout_date2, 150)}.must_raise ArgumentError
#   end


#   it "raises an error if I try to create another block with a room already in another block" do
#     @checkin_date3 = Date.new(2019,1,4)
#     @checkout_date3 = Date.new(2019,1,7)
#     expect{@block3 = Hotel::Block.new([2,5], @checkin_date3, @checkout_date3, 150)}.must_raise ArgumentError
#   end

# end

describe "check_block_availability method" do 
  before do 
    @hotel = Hotel::Hotel_Manager.new(8)
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)

    @checkin_date2 = Date.new(2019,1,5)
    @checkout_date2 = Date.new(2019,1,8)

    @block = Hotel::Block.new([1,2,3,4], @checkin_date, @checkout_date, 150)
    @block2 = Hotel::Block.new([5,6,7,8], @checkin_date2, @checkout_date2, 150)

    # available = @hotel.check_availability(@checkin_date, @checkout_date)
  end

  # it "can show available rooms in the block" do
  #   available = @block.block_availability(@block)
  # end

end

