require_relative "spec_helper"

describe "ReservationManager" do
  let(:manager_new) do
    Hotel::ReservationManager.new
  end

  let(:reservation_generator) do
    # Reservation 1
    start_date = Time.parse("2019-03-11 14:08:45 -0700")
    end_date = Time.parse("2019-03-15 14:08:45 -0700")
    room = 3
    manager_new.create_reservation(start_date, end_date, room)
    # Reservation 2
    start_date = Time.parse("2019-03-20 14:08:45 -0700")
    end_date = Time.parse("2019-03-22 14:08:45 -0700")
    room = 20
    manager_new.create_reservation(start_date, end_date, room)
    # Reservation 3
    start_date = Time.parse("2019-02-27 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    room = 12
    manager_new.create_reservation(start_date, end_date, room)
    # Reservation 4
    start_date = Time.parse("2019-03-19 14:08:45 -0700")
    end_date = Time.parse("2019-03-21 14:08:45 -0700")
    room = 6
    manager_new.create_reservation(start_date, end_date, room)
  end

  it "creates a reservation" do
    expect(reservation_generator).must_be_instance_of Hotel::Reservation
  end

  it "creates a reservation for an available room" do
    reservation_generator
    reservation = manager_new.create_reservation(Time.parse("2019-03-21 14:08:45 -0700"), Time.parse("2019-03-26 14:08:45 -0700"), 6)
    expect(reservation).must_be_instance_of Hotel::Reservation
  end

  it "raises ArgumentError when a room chosen is not existent" do
    expect { manager_new.create_reservation(Time.parse("2019-03-21 14:08:45 -0700"), Time.parse("2019-03-26 14:08:45 -0700"), 24) }.must_raise ArgumentError
  end

  it "raises ArgumentError when a room chosen is not available" do
    reservation_generator

    expect { manager_new.create_reservation(Time.parse("2019-03-19 14:08:45 -0700"), Time.parse("2019-03-26 14:08:45 -0700"), 6) }.must_raise ArgumentError
  end

  it "raises ArgumentError when range of dates are invalid" do
    start_date = Time.parse("2019-03-19 14:08:45 -0700")
    end_date = Time.parse("2019-03-17 14:08:45 -0700")
    room = 4
    expect { manager_new.create_reservation(start_date, end_date, room) }.must_raise ArgumentError
  end

  it "shows the list of rooms in the hotel" do
    expect(manager_new.rooms).must_be_kind_of Array
    # puts "#{manager_new.rooms}"
  end

  it "stores the reservations" do
    reservation_generator

    expect(manager_new.reservations).must_be_kind_of Array
    expect(manager_new.reservations.length).must_equal 4
  end

  it "finds a reservation by id" do
    reservation_generator

    expect(manager_new.find_reservation_by_id(id: 1).start_date).must_equal Time.parse("2019-03-11 14:08:45 -0700")
    expect(manager_new.find_reservation_by_id(id: 2)).must_be_kind_of Hotel::Reservation
    expect(manager_new.find_reservation_by_id(id: 3).start_date).must_equal Time.parse("2019-02-27 14:08:45 -0700")
    expect(manager_new.find_reservation_by_id(id: 4)).must_be_kind_of Hotel::Reservation
  end

  it "raises ArgumentError when the id is not valid" do
    reservation_generator

    expect { manager_new.find_reservation_by_id(id: 8) }.must_raise ArgumentError
  end

  it "finds reservations by date" do
    reservation_generator

    expect(manager_new.find_reservation_by_date(Time.parse("2019-03-19 14:08:45 -0700"), Time.parse("2019-03-22 14:08:45 -0700"))).must_be_kind_of Array
    expect(manager_new.find_reservation_by_date(Time.parse("2019-02-27 14:08:45 -0700"), Time.parse("2019-02-28 14:08:45 -0700"))).must_be_kind_of Array
  end

  it "raises ArgumentError when there are no reservations for date range" do
    reservation_generator

    expect { manager_new.find_reservation_by_date(Time.parse("2019-01-01 14:08:45 -0700"), Time.parse("2019-01-20 14:08:45 -0700")) }.must_raise ArgumentError
    expect { manager_new.find_reservation_by_date(Time.parse("2020-01-27 14:08:45 -0700"), Time.parse("2020-01-28 14:08:45 -0700")) }.must_raise ArgumentError
  end

  it "returns the total cost per reservation" do
    reservation_generator

    expect(manager_new.find_reservation_by_id(id: 1).total_cost).must_equal 800
    expect(manager_new.find_reservation_by_id(id: 3).total_cost).must_equal 200
    expect(manager_new.find_reservation_by_id(id: 2).total_cost).must_equal 400
    expect(manager_new.find_reservation_by_id(id: 4).total_cost).must_equal 400
  end

  it "finds available rooms" do
    reservation_generator
    # puts "HERE #{manager_new.find_available_rooms(Time.parse("2019-03-18 14:08:45 -0700"), Time.parse("2019-03-22 14:08:45 -0700"))}"
    expect(manager_new.find_available_rooms(Time.parse("2019-03-18 14:08:45 -0700"), Time.parse("2019-03-22 14:08:45 -0700"))).must_be_kind_of Array
    expect { manager_new.find_available_rooms(Time.parse("2019-01-24 14:08:45 -0700"), Time.parse("2019-01-27 14:08:45 -0700")) }.must_raise ArgumentError
  end
end
