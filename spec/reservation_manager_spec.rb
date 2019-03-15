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
  let (:manager) {
    Hotel::ReservationManager.new
  }
  it "can make a new reservation" do
    new_reservation = manager.make_reservation("march 15, 2019", "march 20, 2019")
    # expect(new_reservation.room_number).must_equal 6
  end
end

describe "reservations_by_date method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }

  it "can list all the reservations for a specified date range" do
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    list_reservations = manager.reservations_by_date(start_date, end_date)
    ap list_reservations

    expect(list_reservations.length).must_equal 1
  end

  it "returns an empty array when there are no reservations for a specified date range" do
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "April 1, 2019"
    end_date = "April 7, 2019"
    list_reservations = manager.reservations_by_date(start_date, end_date)
    expect(list_reservations).must_be_empty
  end
end

describe "available_rooms method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }

  it "can return available rooms for a specified date range, end_date unavail" do
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 19
  end

  it "can return available rooms for a specified date range, full range unavail" do
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "march 17, 2019"
    end_date = "march 19, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 18
  end

  it "can return available rooms for a specified date range, start_date unavail" do
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "march 20, 2019"
    end_date = "march 25, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 19
  end

  it "can return an empty array when no rooms are available for a specified date range" do
    20.times do
      manager.make_reservation("march 15, 2019", "march 20, 2019")
    end

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
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms).wont_include reservation1.room_number
    # expect(vacant_rooms).wont_include reservation2.room_number
  end
end
