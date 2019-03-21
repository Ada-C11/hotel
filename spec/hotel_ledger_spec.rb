require_relative "spec_helper"
require "date"

describe "HotelLedger class" do
  it "must list all the reservations" do
    reservations = Hotel::HotelLedger.new.reservations
    expect(reservations).must_equal []
  end

  it "must list all rooms in the hotel" do
    rooms = Hotel::HotelLedger.new.rooms
    expect(rooms).must_equal [*(1..20)]
  end

  it "can reserve a room for a given date range" do
    dates = [Date.new(2019, 3, 13), Date.new(2019, 3, 15)]
    ledger = Hotel::HotelLedger.new
    expect(ledger.reservations.length).must_equal 0

    ledger.reserve_date_range(*dates)
    expect(ledger.reservations.length).must_equal 1

    expect(ledger.reservations.first[:in_date]).must_equal dates[0]
    expect(ledger.reservations.first[:out_date]).must_equal dates[1]
  end

  it "list of reservations for a specific date" do
    dates = ([
      [Date.new(2019, 3, 13), Date.new(2019, 3, 15)],
      [Date.new(2019, 3, 12), Date.new(2019, 3, 16)],
      [Date.new(2019, 4, 16), Date.new(2019, 4, 18)],
      [Date.new(2019, 5, 13), Date.new(2019, 6, 15)],
    ])
    ledger = Hotel::HotelLedger.new
    dates.each do |date|
      ledger.reserve_date_range(*date)
    end
    date = Date.new(2019, 3, 13)

    ledger.reservations_on(date).each do |reservation|
      expect(reservation[:in_date]..reservation[:out_date]).must_include date
    end

    expect(ledger.reservations_on(date).length).must_equal 2
  end

  it "must give a total cost for the reservation" do
  end

  #   it "raises an exception for an invalid date range" do
  #     dates = [Date.new(2019, 3, 15), Date.new(2019, 3, 13)]
  #     room = Hotel::HotelLedger.all.first

  #     expect {
  #       room.reserve_date_range(*dates)
  #     }.must_raise ArgumentError
  #   end

  #   it "can list reservations for a specific date" do
  #     rooms = Hotel::HotelLedger.load_test_data([
  #       [Date.new(2019, 3, 13), Date.new(2019, 3, 15)],
  #       [Date.new(2019, 3, 12), Date.new(2019, 3, 16)],
  #       [Date.new(2019, 4, 16), Date.new(2019, 4, 18)],
  #       [Date.new(2019, 5, 13), Date.new(2019, 6, 15)],
  #     ])
  #     reservations_on_date = Hotel::HotelLedger.reservations_on(Date.new(2019, 3, 14))

  #     expect(reservations_on_date.length).must_equal 2

  #     room_numbers = reservations_on_date.map do |reservation|
  #       reservation.room_number
  #     end
  #     expect(room_numbers).must_equal [1, 2]

  #     rooms.each do |room|
  #       expect(room).must_be_kind_of Hotel::HotelLedger
  #     end
  #   end

  #   it "can view a list of rooms that are not reserved for a given date range" do
  #     rooms = Hotel::HotelLedger.load_test_data([
  #       [Date.new(2019, 3, 13), Date.new(2019, 3, 15)],
  #       [Date.new(2019, 3, 12), Date.new(2019, 3, 16)],
  #       [Date.new(2019, 4, 16), Date.new(2019, 4, 18)],
  #       [Date.new(2019, 5, 13), Date.new(2019, 6, 15)],
  #     ])

  #     dates = Date.new(2019, 3, 17), Date.new(2019, 3, 19)
  #     binding.pry
  #     rooms_available = Hotel::HotelLedger.all_available_rooms_on(*dates)

  #     expect(rooms_available.length).must_equal 20

  #     # dates = Date.new(2019, 3, 14), Date.new(2019, 3, 19)
  #     # rooms_available = Hotel::HotelLedger.all_available_rooms_on(*dates)

  #     # expect(rooms_available.length).must_equal 20
  #   end
end
