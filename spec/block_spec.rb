require_relative "spec_helper"
require "pry"

describe "Block" do
  describe "instantiation" do
    before do
      @date_range = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      @rooms = []
      5.times do |i|
        room = Hotel::Room.new(id: i + 1)
        @rooms.push(room)
      end
      @block = Hotel::Block.new(id: 1, date_range: @date_range, price: 150, rooms: @rooms)
    end

    it "is an instance of Block" do
      expect(@block).must_be_instance_of Hotel::Block
    end

    it "is set up for specific attributes and data types" do
      [:id, :date_range, :price, :rooms, :reservations].each do |prop|
        expect(@block).must_respond_to prop
      end

      expect(@block.id).must_be_kind_of Integer
      expect(@block.date_range).must_be_instance_of Hotel::DateRange
      expect(@block.price).must_be_kind_of Integer
      expect(@block.rooms).must_be_instance_of Array
      expect(@block.reservations).must_be_kind_of Array
    end
  end

  describe "invalid room input" do
    before do
      date_range = Hotel::DateRange.new("03-04-2019", "06-04-2019")
    end

    it "raises error for empty array" do
      rooms = []
      expect {
        Hotel::Block.new(id: 1, date_range: @date_range, price: 150, rooms: rooms)
      }.must_raise ArgumentError
    end

    it "raises error for single room" do
      rooms = [(Hotel::Room.new(id: 7))]
      expect {
        Hotel::Block.new(id: 1, date_range: @date_range, price: 150, rooms: rooms)
      }.must_raise ArgumentError
    end

    it "raises error for rooms more than 5" do
      rooms = (1..7).map { |i| Hotel::Room.new(id: i + 1) }
      expect {
        Hotel::Block.new(id: 1, date_range: @date_range, price: 150, rooms: rooms)
      }.must_raise ArgumentError
    end
  end

  describe "room availability" do
    before do
      @room1 = Hotel::Room.new(id: 1)
      @room2 = Hotel::Room.new(id: 2)
      @room3 = Hotel::Room.new(id: 3)
      @rooms = [@room1, @room2]
      @date_range = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      @block = Hotel::Block.new(id: 1, date_range: @date_range, price: 150, rooms: @rooms)
    end

    describe "unavailable room" do
      it "raises error making block with reserved room" do
        rooms = [@room1, @room3]
        Hotel::Reservation.new(
          id: 1,
          date_range: @date_range,
          room: @room1,
          price: 200,
        )
        expect {
          Hotel::Block.new(id: 2, date_range: @date_range, price: 150, rooms: rooms)
        }.must_raise ArgumentError
      end

      it "raises error for making block with blocked room" do
        rooms = [@room2, @room3]
        expect {
          Hotel::Block.new(id: 4, date_range: @date_range, price: 150, rooms: rooms)
        }.must_raise ArgumentError
      end
    end

    describe "blocking rooms" do
      it "is_blocked? method changes blocked room status" do
        expect(@room1.is_blocked?(@date_range)).must_equal true
        expect(@room2.is_blocked?(@date_range)).must_equal true
      end

      it "connect_rooms adds block to all rooms in block" do
        r1block = @room1.blocks
        r2block = @room2.blocks
        expect(r1block.include?(@block)).must_equal true
        expect(r2block.include?(@block)).must_equal true
      end
    end
  end

  describe "bookable_room" do
    before do
      @rooms = (1..5).map do |i|
        Hotel::Room.new(id: i)
      end
      @date_range = Hotel::DateRange.new("03-04-2019", "06-04-2019")
      @block = Hotel::Block.new(id: 1, date_range: @date_range, price: 150, rooms: @rooms)
    end

    it "correctly identifies bookable rooms" do
      4.times do |i|
        Hotel::Reservation.new(
          id: 1,
          date_range: @date_range,
          room: @rooms[i],
          price: 150,
        )
      end
      free_room = @block.bookable_room
      expect(free_room).must_equal @rooms.last
    end

    it "raises error if all rooms in block booked" do
      5.times do |i|
        Hotel::Reservation.new(
          id: 1,
          date_range: @date_range,
          room: @rooms[i],
          price: 150,
        )
      end
      expect { @block.bookable_room }.must_raise ArgumentError
    end
  end
end
