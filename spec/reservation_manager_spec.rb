require_relative "spec_helper"

describe "ReservationManager" do
  it "is an instance of ReservationManager" do
    reservations = Hotel::ReservationManager.new
    expect(reservations).must_be_instance_of Hotel::ReservationManager
    # expect(reservations).must_be_kind_of Array # How do I test for
  end
  it "shows the list of rooms in the hotel" do
    reservations = Hotel::ReservationManager.new
    expect(reservations.rooms).must_be_kind_of Array
    puts "#{reservations.rooms}"
  end
  it "creates a reservation" do
    reservations = Hotel::ReservationManager.new ## I don't know how to access the instance yet
    start_time = Time.parse("2019-03-11 14:08:45 -0700")
    end_time = Time.parse("2019-03-15 14:08:45 -0700")
    expect(reservations.create_reservation(start_time, end_time)).must_be_kind_of Hotel::Reservation
  end
  xit "finds a reservation" do
    reservations = Hotel::ReservationManager ## I don't know how to access the instance yet
    expect(reservations.find_reservation("id")).must_be_kind_of Hotel::Reservation
  end
  xit "returns the cost for a reservation" do
    reservations = Hotel::ReservationManager
    reservation_test = reservations.find_reservation("id")
    expect(reservation_test.cost).must_equal ## A value I need to specify by creating a reservation or something??
  end
  xit "filters reservation for dates" do
    reservations = Hotel::ReservationManager
    expect(reservations.show_reservations).must_be_kind_of Array
  end
end
