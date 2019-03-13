require "simplecov"
SimpleCov.start

require_relative "spec_helper"

describe "Room class" do
  before do
    @room = Hotel::Room.new(room_number: 1)
  end
  it "creates an instance of Room" do
    expect(@room).must_be_kind_of Hotel::Room
  end

  it "includes an array when initialized" do
    expect(@room.reservations).must_be_kind_of Array
  end

  it "includes a cost per night" do
    expect(@room.cost_per_night).must_equal 200.00
  end

  describe "add_reservation method" do
    before do
      @room = Hotel::Room.new(room_number: 1)
      @reservation = Hotel::Reservation.new(check_in: "2019-3-30", check_out: "2019-4-1", room: @room)
    end

    it "adds the reservation" do
      expect(@room.reservations).wont_include @reservation
      previous = @room.reservations.length

      @room.add_reservation(@reservation)

      expect(@room.reservations).must_include @reservation
      expect(@room.reservations.length).must_equal previous + 1
    end
  end
  describe "is_available? method" do
    before do
      @manager = Hotel::Manager.new
      @check_in = "2019-3-20"
      @check_out = "2019-3-21"

      @reservation = @manager.reserve_room(@check_in, @check_out)
      @reserved_room = @reservation.room
    end

    it "returns false if the room is unavailable during a given date range" do
      @check_in = Date.parse(@check_in)
      @check_out = Date.parse(@check_out)
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end
  end
end
