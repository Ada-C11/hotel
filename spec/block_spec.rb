require_relative 'spec_helper'

describe "Block" do
  before do
    @booking = Hotel::Booking.new
    @booking.rooms = Hotel::Room.list_rooms(1, 20, 200)
    @rooms = @booking.rooms[0..4]
    @checkin = "2020-04-01"
    @checkout = "2020-04-05"
    @discounted_rate = 175
    
  end

  describe "#initialize" do
    it "Creates an instance of Block" do
      block = Hotel::Block.new(@checkin, @checkout, @rooms, @discounted_rate)
      expect(block).must_be_kind_of Hotel::Block
    end

    it "Raises an error if attempting to create a block of more than 5 rooms" do
      rooms = @booking.rooms[0..5]
      expect {
        @block = Hotel::Block.new(@checkin, @checkout, rooms, @discounted_rate)
      }.must_raise Hotel::Block::BlockBookingError
    end
  end

  describe "rooms_available" do
    it "Returns a collection of rooms that are not yet reserved through the block" do
      block = Hotel::Block.new(@checkin, @checkout, @rooms, @discounted_rate)
      rooms = block.rooms_available
      expect(rooms).must_equal @rooms
    end
  end
end