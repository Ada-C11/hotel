require_relative 'spec_helper'

describe "Block" do
  before do
    @booking = Hotel::Booking.new
    @booking.rooms = Hotel::Room.list_rooms(1, 20, 200)
  end

  describe "#initialize" do
    it "Creates an instance of Block" do
      date_range = ["2020-04-01", "2020-04-02", "2020-04-03", "2020-04-04"]
      rooms = @booking.rooms[15..19]
      discounted_rate = 175
      block = Hotel::Block.new(date_range, rooms, discounted_rate)
      expect(block).must_be_kind_of Hotel::Block
    end
  end
end