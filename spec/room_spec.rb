require_relative 'spec_helper'

describe "Room" do
  before do 
    @room = Hotel::Room.new(1, 300)
  end
  describe "#initialize" do
    it "Creates an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end

  describe "add_reservation" do
    it "Adds the reservation to @reservations" do
      expect(@room.reservations).must_equal []
      reservation = Hotel::Reservation.new(checkin: "April 10, 2020", checkout: "April 15, 2020", room: @room)
      @room.add_reservation(reservation)
      expect(@room.reservations.length).must_equal 1
    end
  end

  describe "add_block" do
    it "Adds the block to @block" do
      booking = Hotel::Booking.new
      booking.rooms = Hotel::Room.list_rooms(1, 20, 200)
      rooms = booking.get_rooms("April 10, 2020", "April 15, 2020", 3)
      expect(@room.blocks).must_equal []
      block = Hotel::Block.new("April 10, 2020", "April 15, 2020", rooms, 175)
      @room.add_block(block)
      expect(@room.blocks.length).must_equal 1
    end
  end

  describe "is_available?" do
    it "Returns true if the room is available during the given date range" do
      # No reservations made yet for this room
      expect(@room.reservations).must_equal []
      check = @room.is_available?("May 10, 2020", "May 15, 2020")
      expect(check).must_equal true
    end

    it "Returns false if the room is not available during the given date range" do
      reservation = Hotel::Reservation.new(checkin: "April 10, 2020", checkout: "April 15, 2020", room: @room)
      @room.add_reservation(reservation)
      check = @room.is_available?("April 11, 2020", "April 13, 2020")
      expect(check).must_equal false
    end
  end

  describe "list_rooms" do
    before do
      @rooms = Hotel::Room.list_rooms(100, 20, 150)
    end
    it "Generates a collection of multiple rooms" do
      expect(@rooms).must_be_kind_of Array
      expect(@rooms.length).must_equal 20
    end

    it "Has the correct cost" do
      expect(@rooms.first.cost).must_equal 150
    end

    it "Has the correct ID for the first room" do
      expect(@rooms.first.id).must_equal 100
    end

    it "Has the correct ID for the last room" do
      expect(@rooms.last.id).must_equal 119
    end
  end
end