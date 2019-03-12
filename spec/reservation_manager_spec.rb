require_relative "spec_helper"

describe "ReservationManager class" do
  let (:reservation) do
    ReservationManager.new
  end

  describe "initialize" do
    it "Creates an instance of ReservationManager" do
      expect(reservation).must_be_instance_of ReservationManager
    end
  end
  describe "make_reservation method" do
    it "make_reservation method can make an instance of reservation" do
      expect(reservation.make_reservation).must_be_instance_of Reservation
    end
    it "make_reservation adds a reservation to an array of reservations" do
      my_reservation = reservation.make_reservation
      expect(reservation.reservations_array.include?(my_reservation)).must_equal true
    end
  end
  describe "view_all_rooms method" do
    it "rooms array includes 20 rooms" do
      expect(reservation.view_all_rooms.length).must_equal 20
    end
  end
end
