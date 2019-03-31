require_relative "spec_helper"

describe Hotel do
  it "includes room 1 and 20" do
    hotel = Hotel.new

    expect(hotel.rooms).must_include 1
    expect(hotel.rooms).must_include 10
    expect(hotel.rooms).must_include 20
  end

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
    expect(hotel.list_reservations_by_date_range("2019-05-04", "2019-05-05")).must_include reservation
  end

  it "list reservations for date with no reservations" do
    hotel = Hotel.new
    reservation = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation)
    expect(hotel.list_reservations_by_date_range("2019-06-04", "2019-06-05")).wont_include reservation
  end

  it "list reservations when no reservations have been made" do
    hotel = Hotel.new
    expect(hotel.list_reservations_by_date_range("2019-05-04", "2019-05-05")).must_equal []
  end

  it "raises argument error when new reservation is in conflict with existing reservations" do
    hotel = Hotel.new
    reservation1 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation1)
    reservation2 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)

    expect { hotel.add_reservation(reservation2) }.must_raise RuntimeError
  end

  it "raises argument error when new reservation with dates that fall within another reservation" do
    hotel = Hotel.new
    reservation1 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation1)
    reservation2 = Reservation.new(start_date: "2019-05-04", end_date: "2019-05-05", room_number: 5)

    expect { hotel.add_reservation(reservation2) }.must_raise RuntimeError
  end

  it "raises argument error when new reservation with start date that falls within another reservation" do
    hotel = Hotel.new
    reservation1 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation1)
    reservation2 = Reservation.new(start_date: "2019-05-04", end_date: "2019-05-06", room_number: 5)

    expect { hotel.add_reservation(reservation2) }.must_raise RuntimeError
  end

  it "raises argument error when new reservation with end date that falls within another reservation" do
    hotel = Hotel.new
    reservation1 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation1)
    reservation2 = Reservation.new(start_date: "2019-05-01", end_date: "2019-05-04", room_number: 5)

    expect { hotel.add_reservation(reservation2) }.must_raise RuntimeError
  end

  it "list reservations for date with reservations with overlapping start date and end date" do
    hotel = Hotel.new
    reservation1 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation1)
    reservation2 = Reservation.new(start_date: "2019-05-05", end_date: "2019-05-07", room_number: 5)
    hotel.add_reservation(reservation2)

    expect(hotel.list_reservations_by_date_range("2019-05-04", "2019-05-06")).must_include reservation2
  end

  it "lists available rooms" do
    hotel = Hotel.new
    reservation1 = Reservation.new(start_date: "2019-05-03", end_date: "2019-05-05", room_number: 5)
    hotel.add_reservation(reservation1)

    expect(hotel.list_available_rooms("2019-05-03", "2019-05-05")).wont_include 5
    expect(hotel.list_available_rooms("2019-05-03", "2019-05-05")).must_include 20
    expect(hotel.list_available_rooms("2019-05-03", "2019-05-05")).must_include 1
  end
end
