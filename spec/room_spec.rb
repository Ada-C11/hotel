require_relative "spec_helper"
require "Date"
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
    it "raises an error if cost is not a valid input" do
      expect {
        Hotel::Room.new(
          id: 1, cost: -200,
        )
      }.must_raise ArgumentError

      expect {
        Hotel::Room.new(
          id: 1, cost: "something",
        )
      }.must_raise NoMethodError
    end

    it "sets reservations to an empty array if not provided" do
      expect(@room.reservations.length).must_equal 0
    end # needed? needed for block?

    it "has a block parameter" do
      expect(@room.block.length).must_equal 0
      expect(@room.block).must_be_kind_of Array
    end
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

  describe "#add_block" do
    before do
      @collection = []
      @room1 = Hotel::Room.new(
        id: 1,
      )
      @room2 = Hotel::Room.new(
        id: 2,
      )
      @collection << @room1
      @collection << @room2
      p @collection
      @block1 = Hotel::Block.new(
        id: 1,
        start_date: Date.new(2001, 2, 3),
        end_date: Date.new(2001, 2, 5),
        collection_rooms: @collection,
        discounted_rate: 150,
      )
      @room1.add_block(@block1)
      @room2.add_block(@block1)
    end
    it "adds a block to list of hotel blocks" do
      expect(@room1.block.length).must_equal 1
    end
  end
end
