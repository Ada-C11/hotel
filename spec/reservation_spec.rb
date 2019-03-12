require_relative 'spec_helper'

describe "Reservation" do
  describe "#initialize" do
    it "Creates an instance of Reservation" do
      reservation = Hotel::Reservation.new("April 1, 2019", "April 5, 2019")
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "reservation_dates" do
    it "Returns an array of dates for each night of the reservation" do
      reservation = Hotel::Reservation.new("April 1, 2019", "April 5, 2019")
      dates = reservation.reservation_dates
      expect(dates).must_be_kind_of Array
      expect(dates.length).must_equal 4
    end
  end
end