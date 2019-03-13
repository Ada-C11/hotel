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

    it "returns false if the given date range STARTS and ENDS the same day as a reservation" do
      check_in = Date.parse(@check_in)
      check_out = Date.parse(@check_out)
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns false if the given date range STARTS on reservaton's check_in day and ENDS DURING" do
      check_in = Date.parse(@check_in)
      check_out = Date.parse("2020-03-22")
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns false if the given date range STARTS on reservation's check_in day and ENDS AFTER" do
      check_in = Date.parse(@check_in)
      check_out = Date.parse("2020-04-1")
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns true if the given date range STARTS BEFORE and ENDS BEFORE a reservation's date range" do
      check_in = Date.parse(@check_in) - 10
      check_out = Date.parse(@check_out) - 10
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal true
    end

    it "returns false if the given date range STARTS BEFORE and ENDS DURING a reservation's date range" do
      check_in = Date.parse(@check_in) - 10
      check_out = Date.parse(@check_in) + 2
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns false if the date range STARTS BEFORE a reservation and ENDS ON a reservation's check_out day" do
      check_in = Date.parse(@check_in) - 10
      check_out = Date.parse(@check_out)
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns false if the date range STARTS BEFORE and ENDS AFTER a reservation" do
      check_in = Date.parse(@check_in) - 10
      check_out = Date.parse(@check_out) + 5
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns false if the given date range STARTS DURING and ENDS DURING a reservation" do
      check_in = Date.parse(@check_in) + 1
      check_out = Date.parse(@check_in) + 3
      date_range = (check_in..check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns false if the given date range STARTS DURING and ENDS ON reservation's check_out day" do
      @check_in = Date.parse(@check_in) + 1
      @check_out = Date.parse(@check_out)
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns false if the given date range STARTS DURING and ENDS AFTER a reservation's date range" do
      @check_in = Date.parse(@check_in) + 1
      @check_out = Date.parse(@check_out) + 2
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal false
    end

    it "returns true if the given date range STARTS AFTER and ENDS AFTER a reservation" do
      @check_in = Date.parse(@check_in) + 10
      @check_out = Date.parse(@check_out) + 10
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal true
    end

    it "returns true when a given date range STARTS on a reservation's end date" do
      @check_in = Date.parse(@check_out)
      @check_out = (Date.parse(@check_out)) + 5
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal true
    end

    it "returns true if there are currently no reservations attached to a room" do
      @reserved_room.reservations.clear

      @check_in = Date.today
      @check_out = Date.today + 1
      date_range = (@check_in..@check_out)
      availability = @reserved_room.is_available?(date_range)

      expect(availability).must_equal true
    end
  end
end
