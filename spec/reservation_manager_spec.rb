require_relative "spec_helper"

describe "ReservationManager class" do
  describe "initialize" do
    it "Creates an instance of ReservationManager" do
      reservation_manager = ReservationManager.new
      expect(reservation_manager).must_be_instance_of ReservationManager
    end
  end
  describe "make_reservation method" do
    it "make_reservation method can make an instance of reservation" do
      my_reservation = ReservationManager.new
      expect(my_reservation.make_reservation).must_be_instance_of Reservation
    end
    it "make_reservation adds a reservation to an array of reservations" do
      reservation_manager = ReservationManager.new
      my_reservation = reservation_manager.make_reservation
      expect(reservation_manager.reservations_array.include?(my_reservation)).must_equal true
    end
  end
  describe "view_all_rooms method" do
    it "rooms array includes 20 rooms" do
      reservation_manager = ReservationManager.new
      expect(reservation_manager.view_all_rooms.length).must_equal 20
    end
  end
end
