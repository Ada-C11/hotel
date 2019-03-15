require_relative "spec_helper"
require "date"
require "pry"

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

    it "contains all the possible rooms" do
      expect(@hotel.all_rooms.length).must_equal 20
      expect(@hotel.all_rooms[0]).must_be_kind_of HotelSystem::Room
      expect(@hotel.all_rooms[19]).must_be_kind_of HotelSystem::Room
    end
  end

  describe "reserve_room method" do
    let (:hotel) { HotelSystem::Hotel.new }
    let (:room) { hotel.all_rooms[0] }

    it "can add the reservation to the @all_reservations array" do
      hotel.reserve_room(room,
                         Date.new(2019, 3, 11),
                         Date.new(2019, 3, 14),
                         "Sam")
      hotel.reserve_room(room,
                         Date.new(2019, 3, 11),
                         Date.new(2019, 3, 14),
                         "Sam")
      hotel.reserve_room(room,
                         Date.new(2019, 3, 11),
                         Date.new(2019, 3, 14),
                         "Sam")

      expect(hotel.all_reservations.length).must_equal 3
      expect(hotel.all_reservations[0]).must_be_kind_of HotelSystem::Reservation
      expect(hotel.all_reservations[1]).must_be_kind_of HotelSystem::Reservation
      expect(hotel.all_reservations[2]).must_be_kind_of HotelSystem::Reservation
    end

    it "can add the reservation to the assigned room's reservation array" do
      hotel.reserve_room(room,
                         Date.new(2019, 3, 11),
                         Date.new(2019, 3, 14),
                         "Sam")
      expect(room.reservations.length).must_equal 1
      expect(room.reservations[0]).must_be_kind_of HotelSystem::Reservation
    end

    it "can assign a room, that doesn't have other conflicting reservations, to the reservation if the selected room is not available" do
      hotel.reserve_room(room,
                         Date.new(2019, 3, 10),
                         Date.new(2019, 3, 13),
                         "Jon")
      hotel.reserve_room(room,
                         Date.new(2019, 3, 11),
                         Date.new(2019, 3, 14),
                         "Sam")
      hotel.reserve_room(room,
                         Date.new(2019, 3, 11),
                         Date.new(2019, 3, 14),
                         "Dee")

      expect(hotel.all_reservations[0].room.number).must_equal 1
      expect(hotel.all_reservations[1].room.number).must_equal 2
      expect(hotel.all_reservations[2].room.number).must_equal 3
      expect(hotel.all_reservations.length).must_equal 3
    end

    it "raises an error if no rooms are available at all during specified dates" do
      20.times do
        hotel.reserve_room(room,
                           Date.new(2019, 3, 10),
                           Date.new(2019, 3, 13),
                           "Jon")
      end

      expect do
        hotel.reserve_room(room,
                           Date.new(2019, 3, 11),
                           Date.new(2019, 3, 14),
                           "Zoe")
      end.must_raise ArgumentError
    end
  end

  describe "room_available? method" do
    before do
      @hotel = HotelSystem::Hotel.new
      @hotel.all_rooms.slice!(2..19)

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
    end

    it "assigns the first available room" do
      expect(@hotel.room_available?(Date.new(2019, 3, 13), Date.new(2019, 3, 14))).must_equal @hotel.all_rooms[0]
    end

    it "assigns a subsequent room if previous rooms have a conflicting reservation" do
      expect(@hotel.room_available?(Date.new(2019, 3, 11), Date.new(2019, 3, 14))).must_equal @hotel.all_rooms[1]
    end

    it "returns false if no room is available during the specified dates" do
      expect(@hotel.room_available?(Date.new(2019, 3, 11), Date.new(2019, 3, 15))).must_equal false
    end
  end
end
