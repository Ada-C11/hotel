require_relative 'spec_helper'

describe "Block" do
  before do
    @booking = Hotel::Booking.new
    @booking.rooms = Hotel::Room.list_rooms(1, 20, 200)
  end

  describe "#initialize" do
    before do
      @date_range = ["2020-04-01", "2020-04-02", "2020-04-03", "2020-04-04"]
      @rooms = @booking.rooms[0..4]
      @discounted_rate = 175
    end

    it "Creates an instance of Block" do
      block = Hotel::Block.new(@date_range, @rooms, @discounted_rate, @booking)
      expect(block).must_be_kind_of Hotel::Block
    end

    it "Raises an error if at least one of the rooms is unavailable during the date range" do
      20.times do
        @booking.request_reservation("April 1, 2020", "April 5, 2020")
      end
      expect {
        block = Hotel::Block.new(@date_range, @rooms, @discounted_rate, @booking)
      }.must_raise ArgumentError
    end

  end
end