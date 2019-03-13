require_relative "spec_helper"
require "awesome_print"

describe "Reservation_manager instantiation" do
  it "is an instance of Reservation Manager" do
    manager = Hotel::ReservationManager.new
    expect(manager).must_be_kind_of Hotel::ReservationManager
  end
end

describe "all_rooms method" do
  it "can list all rooms in the hotel" do
    rooms = Hotel::ReservationManager.new
    expect(rooms.all_rooms.length).must_equal 20
  end
end

describe "make_reservation method" do
  it "can make a new reservation" do
    manager = Hotel::ReservationManager.new
    new_reservation = manager.make_reservation(6, "march 15, 2019", "march 20, 2019")
    expect(new_reservation.room_number).must_equal 6
  end
end

describe "reservations_by_date method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }

  it "can list all the reservations for a specified date range" do
    reservation1 = manager.make_reservation(6, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(7, "march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    list_reservations = manager.reservations_by_date(start_date, end_date)
    ap list_reservations

    expect(list_reservations.length).must_equal 1
  end
end

describe "available_rooms method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }

  it "can return available rooms for a specified date range, end_date unavail" do
    reservation1 = manager.make_reservation(2, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(3, "march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 19
  end

  it "can return available rooms for a specified date range, full range unavail" do
    reservation1 = manager.make_reservation(5, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(6, "march 17, 2019", "march 22, 2019")
    start_date = "march 17, 2019"
    end_date = "march 19, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 18
  end

  it "can return available rooms for a specified date range, start_date unavail" do
    reservation1 = manager.make_reservation(7, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(8, "march 17, 2019", "march 22, 2019")
    start_date = "march 20, 2019"
    end_date = "march 25, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 19
  end

  it "can return an empty array when no rooms are available for a specified date range" do
    reservation1 = manager.make_reservation(1, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(2, "march 15, 2019", "march 20, 2019")
    reservation3 = manager.make_reservation(3, "march 15, 2019", "march 20, 2019")
    reservation4 = manager.make_reservation(4, "march 15, 2019", "march 20, 2019")
    reservation5 = manager.make_reservation(5, "march 15, 2019", "march 20, 2019")
    reservation6 = manager.make_reservation(6, "march 15, 2019", "march 20, 2019")
    reservation7 = manager.make_reservation(7, "march 15, 2019", "march 20, 2019")
    reservation8 = manager.make_reservation(8, "march 15, 2019", "march 20, 2019")
    reservation9 = manager.make_reservation(9, "march 15, 2019", "march 20, 2019")
    reservation10 = manager.make_reservation(10, "march 15, 2019", "march 20, 2019")
    reservation11 = manager.make_reservation(11, "march 15, 2019", "march 20, 2019")
    reservation12 = manager.make_reservation(12, "march 15, 2019", "march 20, 2019")
    reservation13 = manager.make_reservation(13, "march 15, 2019", "march 20, 2019")
    reservation14 = manager.make_reservation(14, "march 15, 2019", "march 20, 2019")
    reservation15 = manager.make_reservation(15, "march 15, 2019", "march 20, 2019")
    reservation16 = manager.make_reservation(16, "march 15, 2019", "march 20, 2019")
    reservation17 = manager.make_reservation(17, "march 15, 2019", "march 20, 2019")
    reservation18 = manager.make_reservation(18, "march 15, 2019", "march 20, 2019")
    reservation19 = manager.make_reservation(19, "march 15, 2019", "march 20, 2019")
    reservation20 = manager.make_reservation(20, "march 15, 2019", "march 20, 2019")
    start_date = "march 15, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms).must_be_empty
  end

  it "includes all rooms if no reservations" do
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 20
  end

  it "does not include the booked rooms" do
    reservation1 = manager.make_reservation(2, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(3, "march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms).wont_include 2
  end
end
