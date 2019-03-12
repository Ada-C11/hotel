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
end
