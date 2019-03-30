require_relative "spec_helper"

describe Hotel do
  it "list rooms" do
    hotel = Hotel.new
    expect(hotel.list_rooms).must_equal (1..20).to_a
  end

  it "list specific room" do
    hotel = Hotel.new
    expect(hotel.list_rooms).must_include 20
  end

  it "add reservation" do
    hotel = Hotel.new
    reservation = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation)
    expect(hotel.reservations).must_include reservation
  end

  it "list reservations for date with reservations" do
    hotel = Hotel.new
    reservation = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation)
    expect(hotel.list_reservations_by_date_range(Date.parse("2019-05-04"), Date.parse("2019-05-05"))).must_include reservation
  end

  it "list reservations for date with no reservations" do
    hotel = Hotel.new
    reservation = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation)
    expect(hotel.list_reservations_by_date_range(Date.parse("2019-06-04"), Date.parse("2019-06-05"))).wont_include reservation
  end

  it "list reservations when not reservations have been made" do
    hotel = Hotel.new
    expect(hotel.list_reservations_by_date_range(Date.parse("2019-05-04"), Date.parse("2019-05-05"))).must_equal []
  end

  it "raises argument error when new reservation is in conflict with existing reservations" do
    hotel = Hotel.new
    reservation1 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation1)
    reservation2 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)

    expect { hotel.add_reservation(reservation2) }.must_raise RuntimeError
  end
end
