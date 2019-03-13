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
  # describe "Manager" do
  let (:manager) {
    Hotel::ReservationManager.new
  }

  it "can list all the reservations for a specified date range" do
    # manager = Hotel::ReservationManager.new
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
  it "can return available rooms for a specified date range" do
    manager = Hotel::ReservationManager.new
    reservation1 = manager.make_reservation(2, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(3, "march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 19
  end

  it "does not include the booked rooms" do
    manager = Hotel::ReservationManager.new
    reservation1 = manager.make_reservation(2, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(3, "march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms).wont_include 2
  end
end
