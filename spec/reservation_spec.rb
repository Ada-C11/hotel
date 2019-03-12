require_relative "spec_helper"
require "date"

describe "Reservation class" do
  describe "initialize" do
    before do
    end

    it "is an instance of a reservation" do
      room = HotelSystem::Room.new(1)
      reservation = HotelSystem::Reservation.new(room: room,
                                                 start_date: Date.new(2019, 3, 11),
                                                 end_date: Date.new(2019, 3, 14),
                                                 guest: "Sam")
      expect(reservation).must_be_kind_of HotelSystem::Reservation
    end

    it "raises an error if start date is before end date" do
      room2 = HotelSystem::Room.new(2)
      reservation2 = HotelSystem::Reservation.new(room: room2,
                                                  start_date: Date.new(2019, 3, 14),
                                                  end_date: Date.new(2019, 3, 11),
                                                  guest: "Sam")
      expect(reservation2).must_raise ArgumentError
    end
  end

  describe "calculate cost method" do
    before do
      @room = HotelSystem::Room.new(1)
      @reservation = HotelSystem::Reservation.new(room: @room,
                                                 start_date: Date.new(2019, 3, 11),
                                                 end_date: Date.new(2019, 3, 14),
                                                 guest: "Sam")
    end
    it "can accurately calculate the cost for a reservation" do
      expect(@reservation.calculate_cost).must_equal 600.00
    end
  end
end
