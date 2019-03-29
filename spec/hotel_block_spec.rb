require 'date'
require_relative 'spec_helper'

describe "available?" do 
  before do 
    @hotel = Hotel::Hotel_Manager.new(8)
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)
    @block = Hotel::Block.new([1,2,3,4], @checkin_date, @checkout_date, 150)
  end

  it "will return true if there are available rooms in the block" do
    expect(@block.available?).must_equal true
  end

end

describe "reserve_room?" do 
  before do 
    @hotel = Hotel::Hotel_Manager.new(4)
    @checkin_date = Date.new(2019,1,4)
    @checkout_date = Date.new(2019,1,7)
    @block = Hotel::Block.new([1,2,3,4], @checkin_date, @checkout_date, 150)
    @reserved1 = @block.reserve_room
    @reserved2 = @block.reserve_room
    @reserved3 = @block.reserve_room
    @reserved4 = @block.reserve_room
  end

  it "moves a room from available_rooms to reserved_rooms" do 
    expect(@block.reserved_rooms).must_include 4
    expect(@block.available_rooms).wont_include 4
  end

  it "raises an error if there are no available rooms" do 
    expect{reserved5 = @block.reserve_room}.must_raise ArgumentError
  end
end
