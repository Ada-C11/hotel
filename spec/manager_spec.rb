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

  it "includes an array of rooms" do
    expect(@manager.rooms).must_be_kind_of Array
  end

  it "contains Room objects inside the rooms array" do
    room = @manager.rooms[0]

    expect(room).must_be_kind_of Hotel::Room
  end

  it "has 20 Rooms" do
    expect(@manager.rooms.length).must_equal 20
  end

  it "can make a reservation" do
    reservation = @manager.make_reservation("2019-3-20", "2019-3-20")
    expect(reservation).must_be_kind_of Hotel::Reservation
  end

  it "can reserve an available room" do
    reservation = @manager.make_reservation("2019-3-20", "2019-3-20")

    selected_room = ""
    @manager.rooms.each do |room|
      if room.room_number == reservation.room_number
        selected_room = room
        break
      end
    end

    expect(reservation.room_number).must_be_kind_of Integer
    expect(selected_room.reservations.length).must_equal 1
  end
end
