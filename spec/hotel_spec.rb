require_relative "spec_helper"

describe Hotel do
  it "list_rooms" do
    hotel = Hotel.new
    expect(hotel.list_rooms).must_equal [1..20]
  end

  it "add_reservation" do
    hotel = Hotel.new
    reservation = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation)
    expect(hotel.reservations).must_include reservation
  end

  it "list_reservations" do
    hotel = Hotel.new
    reservation = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation)
    expect(hotel.list_reservations_by_date(Date.parse("2019-05-04"))).must_include reservation
  end
end
