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
  end
end