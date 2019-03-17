require_relative "spec_helper"
require "date"

describe "Room class" do
  it "must list all the rooms" do
    rooms = Hotel::Room.all
    expect(rooms.length).must_be :>, 0

    rooms.each do |room|
      expect(room).must_be_kind_of Hotel::Room
    end
  end

  it "can reserve a room for a given date range and give total cost" do
    dates = [Date.new(2019, 3, 13), Date.new(2019, 3, 15)]
    room = Hotel::Room.all.first
    room.reserve_date_range(*dates)
    expect(room.reserved_on?(*dates)).must_equal true
    expect(room.total_cost).must_equal 400.00
  end

  it "raises an exception for an invalid date range" do
    dates = [Date.new(2019, 3, 15), Date.new(2019, 3, 13)]
    room = Hotel::Room.all.first

    expect {
      room.reserve_date_range(*dates)
    }.must_raise ArgumentError
  end

  it "can list reservations for a specific date" do
    rooms = Hotel::Room.load_test_data([
      [Date.new(2019, 3, 13), Date.new(2019, 3, 15)],
      [Date.new(2019, 3, 12), Date.new(2019, 3, 16)],
      [Date.new(2019, 4, 16), Date.new(2019, 4, 18)],
      [Date.new(2019, 5, 13), Date.new(2019, 6, 15)],
    ])
    reservations_on_date = Hotel::Room.reservations_on(Date.new(2019, 3, 14))

    expect(reservations_on_date.length).must_equal 2

    room_numbers = reservations_on_date.map do |reservation|
      reservation.room_number
    end
    expect(room_numbers).must_equal [1, 2]

    rooms.each do |room|
      expect(room).must_be_kind_of Hotel::Room
    end
  end
end
