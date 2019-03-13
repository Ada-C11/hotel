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
      @check_in = "2020-3-20"
      @check_out = "2020-3-25"

      @reservation = @manager.reserve_room(@check_in, @check_out)
      @reserved_room = @reservation.room
    end

    it "decides a room is unavailable if the given date range matches a reservation" do
      @check_in = Date.parse(@check_in)
      @check_out = Date.parse(@check_out)
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "decides a room is unavailable if the given date range overlaps with a reservation" do
      @check_in = (Date.parse(@check_in)) + 2
      @check_out = Date.parse(@check_out)
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "decides a room is available if there's no overlap between date ranges" do
      @check_in = Date.parse(@check_in) + 10
      @check_out = Date.parse(@check_out) + 10
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal true
    end

    it "decides a room is available when a given date range's check_in day equals a reservation's check_out day" do
      @check_in = Date.parse(@check_out)
      @check_out = (Date.parse(@check_out)) + 5
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal true
    end

    it "decides a room is available even if there are no reservations attached to it" do
      @reserved_room.reservations.clear

      @check_in = Date.today
      @check_out = Date.today + 1
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal true
    end
  end
end
