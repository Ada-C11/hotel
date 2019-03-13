require_relative "spec_helper"

describe "ReservationManager" do
  let(:manager_new) do
    Hotel::ReservationManager.new
  end
  let(:reservation_generator) do
    # Reservation 1
    start_date = Time.parse("2019-03-11 14:08:45 -0700")
    end_date = Time.parse("2019-03-15 14:08:45 -0700")
    manager_new.create_reservation(start_date, end_date)
    # Reservation 2
    start_date = Time.parse("2019-03-20 14:08:45 -0700")
    end_date = Time.parse("2019-03-22 14:08:45 -0700")
    manager_new.create_reservation(start_date, end_date)
    # Reservation 3
    start_date = Time.parse("2019-02-27 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    manager_new.create_reservation(start_date, end_date)
  end
  it "creates a reservation" do
    # should I instantiate Reservation manager?? I think I just need to create Reservation objects and don't initialize the RM class
    expect(reservation_generator).must_be_instance_of Hotel::Reservation
    # expect(reservations).must_be_kind_of Array # How do I test for
  end
  it "shows the list of rooms in the hotel" do
    expect(manager_new.rooms).must_be_kind_of Array
    # puts "#{manager_new.rooms}"
  end
  it "stores the reservations" do
    reservation_generator

    expect(manager_new.reservations).must_be_kind_of Array
    expect(manager_new.reservations.length).must_equal 3
  end

  it "finds a reservation by id" do
    reservation_generator

    # expect(manager_new.find_reservation(id: 1)).must_be_kind_of Hotel::Reservation
    expect(manager_new.find_reservation(id: 1).start_date).must_equal Time.parse("2019-03-11 14:08:45 -0700")
    # expect(manager_new.find_reservation(id: 3)).must_be_kind_of Hotel::Reservation
    expect(manager_new.find_reservation(id: 3).start_date).must_equal Time.parse("2019-02-27 14:08:45 -0700")
  end

  it "finds a reservation by date" do
    reservation_generator

    expect(manager_new.find_reservation(date: Time.parse("2019-03-13 14:08:45 -0700"))).must_be_kind_of Array  #Hotel::Reservation
    # expect(manager_new.find_reservation(date: Time.parse("2019-03-21 14:08:45 -0700"))).must_be_kind_of Hotel::Reservation
    # expect(manager_new.find_reservation(date: Time.parse("2019-02-27 14:08:45 -0700"))).must_be_kind_of Hotel::Reservation
  end

  it "raises ArgumentError when there are no reservations for date" do
    reservation_generator ## Think about where to raise the argument error
    expect { manager_new.find_reservation(date: Time.parse("2019-01-01 14:08:45 -0700")) }.must_raise ArgumentError
  end

  xit "returns the cost by a reservation" do
    reservation_generator

    # expect(manager_new.find_reservation(id: 1).total_cost).must_equal 800

    # expect(manager_new.find_reservation(date: Time.parse("2019-03-12 14:08:45 -0700")).total_cost).must_equal 800
    expect(manager_new.find_reservation(date: Time.parse("2019-03-20 14:08:45 -0700")).total_cost).must_equal 400 ## A value I need to specify by creating a reservation or something??
  end
  xit "filters reservation for dates" do
    reservations = manager_new
    expect(reservations.show_reservations).must_be_kind_of Array
  end
end
