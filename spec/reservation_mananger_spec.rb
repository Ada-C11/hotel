require_relative "spec_helper"

describe "Reservation Manager class initialization & set up" do
  it "will return an instance of Reservation_Manager" do
    test_manager = Reservation_Manager.new
    expect(test_manager).must_be_kind_of Reservation_Manager
  end

  it "contains a room instance variable that contains 20 rooms with correstponding ID and availability" do
    test_manager = Reservation_Manager.new
    expect(test_manager.rooms).must_be_kind_of Array
    expect(test_manager.rooms.length).must_equal 20
  end
end

describe "#make_reservation in Reservation Manager" do
  it "will contain a collection of Reservation instances" do
    test_manager = Reservation_Manager.new
    test_reserve = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")
    expect(test_manager.all_reservations).must_be_kind_of Array

    test_manager.make_reservation(test_reserve)
    expect(test_manager.all_reservations[0]).must_be_kind_of Reservation
  end

  it "returns the correct number of reservations" do
    test_manager = Reservation_Manager.new
    test_reserve1 = Reservation.new(1, check_in: "2019-3-15", check_out: "2019-3-20")
    test_reserve2 = Reservation.new(2, check_in: "2019-3-24", check_out: "2019-3-30")
    test_reserve3 = Reservation.new(2, check_in: "2019-4-4", check_out: "2019-4-6")

    test_manager.make_reservation(test_reserve1)
    test_manager.make_reservation(test_reserve2)
    test_manager.make_reservation(test_reserve3)
    expect(test_manager.all_reservations.length).must_equal 3
  end
end
