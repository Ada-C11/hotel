require_relative 'spec_helper'

describe "Block" do
  before do
    @booking = Hotel::Booking.new
    @booking.rooms = Hotel::Room.list_rooms(1, 20, 200)
    @rooms = @booking.rooms[0..4]
    @checkin = "2020-04-01"
    @checkout = "2020-04-05"
    @discounted_rate = 175
    @block = Hotel::Block.new(@checkin, @checkout, @rooms, @discounted_rate)
  end

  describe "#initialize" do
    it "Creates an instance of Block" do
      expect(@block).must_be_kind_of Hotel::Block
    end
  end

  describe "rooms_available" do
    it "Returns a collection of rooms that are not yet reserved through the block" do
      rooms = @block.rooms_available
      expect(rooms).must_equal @rooms
    end
  end
end