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
      expect(my_reservation.make_reservation(start_date: "3rd April 2020", end_date: "4th April 2020", reservation_id: 5)).must_be_instance_of Reservation
    end
    # it "make_reservation adds a reservation to an array of reservations" do
    #     my_reservation = ReservationManager.new(start_date: "3rd April 2020", end_date: "4th April 2020", reservation_id: 5)
    #     expect(@reservations_array.include?(my_reservation)
    # end
  end
end
