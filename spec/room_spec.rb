require_relative "spec_helper"

describe "Room class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(
        id: 1,
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "default cost is $200" do
      expect(@room.cost).must_equal 200
    end

    it "sets reservations to an empty array if not provided" do
      expect(@room.reservations.length).must_equal 0
    end # needed?
  end

  describe "#add_reservation" do
    before do
      @room = Hotel::Room.new(
        id: 1,
      )
      @reservation = Hotel::Reservation.new(
        id: 1,
        start_date: Date.new(2001, 2, 3),
        end_date: Date.new(2001, 2, 5),
        room: @room,
      )
      @room.add_reservation(@reservation)
    end

    it "adds a new reservation to list of reservations" do
      expect(@room.reservations.length).must_equal 1
    end

    it "is of object Hotel::Reservation" do
      expect(@room.reservations[0]).must_be_kind_of Hotel::Reservation
    end
  end
end
