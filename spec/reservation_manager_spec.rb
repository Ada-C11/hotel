require_relative "spec_helper"

describe "Reservation_manager instantiation" do
  it "is an instance of Reservation Manager" do
    guest = Hotel::ReservationManager.new
    expect(guest).must_be_kind_of Hotel::ReservationManager
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
  it "can list all the reservations for a specified date" do
    manager = Hotel::ReservationManager.new
    reservation1 = manager.make_reservation(6, "march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation(7, "march 17, 2019", "march 22, 2019")
    date = Date.parse("march 18, 2019")
    list_reservations = manager.reservations_by_date(date)
    expect(list_reservations.length).must_equal 2
  end
end
