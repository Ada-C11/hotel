require_relative "spec_helper"
require 'date'

describe "Hotel class" do
  describe "initialize" do
    before do
      @hotel = HotelSystem::Hotel.new
    end

    it "is an instance of a Hotel" do
      expect(@hotel).must_be_kind_of HotelSystem::Hotel
    end

    it "establishes the base data structures when instantiated" do
      expect(@hotel.all_rooms).must_be_kind_of Array
      expect(@hotel.all_reservations).must_be_kind_of Array
    end

    it "lists all the possible rooms" do
      expect(@hotel.all_rooms.length).must_equal 20
    end
  end

  describe "room_available? method" do
    before do
      @hotel = HotelSystem::Hotel.new

      @reservation1 = HotelSystem::Reservation.new(room: 1,
                                                   start_date: Date.new(2019, 3, 10),
                                                   end_date: Date.new(2019, 3, 12),
                                                   guest: "Sam")
      @hotel.all_rooms[0].reservations << @reservation1

      @reservation2 = HotelSystem::Reservation.new(room: 2,
                                                   start_date: Date.new(2019, 3, 14),
                                                   end_date: Date.new(2019, 3, 16),
                                                   guest: "Jan")
      @hotel.all_rooms[1].reservations << @reservation2
      # @reservation3 = HotelSystem::Reservation.new(room: 3,
      #                                             start_date: Date.new(2019, 3, 11),
      #                                             end_date: Date.new(2019, 3, 14),
      #                                             guest: "Sam")
    end

    it "assigns the first available room" do
      expect(@hotel.room_available?(Date.new(2019, 3, 13), Date.new(2019, 3, 14))).must_equal @hotel.all_rooms[0]
    end

    it "assigns a subsequent room if previous rooms have a conflicting reservation" do
      expect(@hotel.room_available?(Date.new(2019, 3, 11), Date.new(2019, 3, 14))).must_equal @hotel.all_rooms[1]
    end
  end
end
