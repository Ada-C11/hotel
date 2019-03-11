require_relative "spec_helper"

describe "ReservationManager" do
  it "is an instance of ReservationManager" do
    reservations = Hotel::ReservationManager ## I don't know how to access the instance yet maybe set it to an arrar at the begining in ReservationManager
    expect(reservations).must_be_instance_of Hotel::ReservationManager
    expect(reservations).must_be_kind_of Array
  end
  it "creates a reservation" do
    reservations = Hotel::ReservationManager ## I don't know how to access the instance yet
    expext(reservations.create_reservation).must_be_kind_of Hotel::Reservation
  end
  it "finds a reservation" do
    reservations = Hotel::ReservationManager ## I don't know how to access the instance yet
    expect(reservations.find_reservation("id")).must_be_kind_of Hotel::Reservation
  end
  it "returns the cost for a reservation" do
    reservations = Hotel::ReservationManager
    reservation_test = reservations.find_reservation("id")
    expect(reservation_test.cost).must_equal ## A value I need to specify by creating a reservation or something??
  end
  it "filters reservation for dates" do
    reservations = Hotel::ReservationManager
    expect(reservations.show_reservations).must_be_kind_of Array
  end
end
