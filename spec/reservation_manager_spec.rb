require_relative "spec_helper"

describe "ReservationManager class" do
  let (:reservation_manager) do
    ReservationManager.new
  end

  describe "initialize" do
    it "Creates an instance of ReservationManager" do
      expect(reservation_manager).must_be_instance_of ReservationManager
    end
  end
  describe "make_reservation method" do
    it "make_reservation method can make an instance of reservation" do
      expect(reservation_manager.make_reservation).must_be_instance_of Reservation
    end
    it "make_reservation adds a reservation to an array of reservations" do
      my_reservation = reservation_manager.make_reservation
      expect(reservation_manager.reservation_array.include?(my_reservation)).must_equal true
    end
  end
  describe "view_all_rooms method" do
    it "rooms array includes 20 rooms" do
      expect(reservation_manager.view_all_rooms.length).must_equal 20
    end
  end
  describe "access_reservations_by_date method" do
    it "access_reservations_by_date method must return an array" do
      first_reservation = reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019")
      second_reservation = reservation_manager.make_reservation(start_date: "2nd June 2019", end_date: "5th June 2019")
      reservation_manager_2 = ReservationManager.new
      expect(reservation_manager.access_reservations_by_date("4th Jul 2019")).must_be_instance_of Array
    end
    it "access_reservations_by_date method must return an array containing reservations matching the date searched" do
      first_reservation = reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019")
      second_reservation = reservation_manager.make_reservation(start_date: "2nd June 2019", end_date: "5th June 2019")
      third_reservation = reservation_manager.make_reservation(start_date: "1st July 2019", end_date: "7th July 2019")
      expect(reservation_manager.access_reservations_by_date("4th Jul 2019").length).must_equal 2
    end
    it "access_reservations_by_date method will return an empty array if the date searched has no matches" do
      first_reservation = reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019")
      second_reservation = reservation_manager.make_reservation(start_date: "2nd June 2019", end_date: "5th June 2019")
      expect(reservation_manager.access_reservations_by_date("10th Jul 2019").length).must_equal 0
    end
  end
end
