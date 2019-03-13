require "simplecov"
SimpleCov.start

require_relative "spec_helper"
require_relative "../lib/manager.rb"

describe "Manager class" do
  before do
    @manager = Hotel::Manager.new
  end
  it "creates an instance of Manager" do
    expect(@manager).must_be_kind_of Hotel::Manager
  end

  it "includes an array of Rooms" do
    expect(@manager.rooms).must_be_kind_of Array
  end

  it "contains Room objects inside the rooms array" do
    room = @manager.rooms[0]

    expect(room).must_be_kind_of Hotel::Room
  end

  it "has 20 Rooms" do
    expect(@manager.rooms.length).must_equal 20
  end

  it "has an array of Reservations" do
    expect(@manager.reservations).must_be_kind_of Array
  end

  it "starts with an empty array of Reservations" do
    expect(@manager.reservations.length).must_equal 0
  end

  describe "reserve_room method" do
    before do
      @previous = @manager.reservations.length
      @reservation = @manager.reserve_room("2019-3-20", "2019-3-21")
    end
    it "can make a reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "can reserve an available room" do
      selected_room = ""
      @manager.rooms.each do |room|
        if room.room_number == @reservation.room.room_number
          selected_room = room
          break
        end
      end

      expect(@reservation.room.room_number).must_be_kind_of Integer
      expect(selected_room.reservations.length).must_equal 1
    end

    it "can assign a unique id to the new reservation" do
      expect(@reservation.id).must_equal(@previous + 1)
    end
  end

  describe "list_reservations_on method" do
    it "can list reservations associated with a specific date" do
      5.times do
        reservation = @manager.reserve_room("2019-3-20", "2019-3-25")
      end

      list = @manager.list_reservations_on("2019-3-23")

      expect(list.length).must_equal 5
      expect(list[0]).must_be_kind_of Hotel::Reservation
    end
  end

  describe "list_available_rooms" do
    before do
      @manager = Hotel::Manager.new
      @reservation = @manager.reserve_room("2020-03-20", "2020-03-25")
      @reserved_room = @reservation.room
      @available_rooms = @manager.list_available_rooms("2020-03-20", "2020-03-25")
    end

    it "can create a list of rooms" do
      expect(@available_rooms).must_be_kind_of Array
      expect(@available_rooms[0]).must_be_kind_of Hotel::Room
    end

    it "only puts available rooms inside that list" do
      expect(@available_rooms.length).must_equal 19
    end

    it "returns a string if there are no available rooms" do
      100.times do
        @manager.reserve_room("2020-03-20", "2020-03-25")
      end

      available_rooms = @manager.list_available_rooms("2020-03-20", "2020-03-25")

      expect(available_rooms).must_be_kind_of String
    end
  end
end
