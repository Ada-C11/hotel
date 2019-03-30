require_relative 'spec_helper'

describe "Reservation" do
  describe "#initialize" do
    it "Creates an instance of Reservation" do
      reservation = Hotel::Reservation.new(checkin: "April 1, 2019", checkout: "April 5, 2019")
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "includes_date?" do
    before do
      @reservation = Hotel::Reservation.new(checkin: "April 1, 2019", checkout: "April 5, 2019")
    end
    it "Returns true if dates includes the given date" do
      date_check = @reservation.includes_date?("April 1, 2019")
      expect(date_check).must_equal true
    end

    it "Returns false if dates includes the given date" do
      date_check = @reservation.includes_date?("March 1, 2019")
      expect(date_check).must_equal false
    end
  end

  describe "reservation_dates" do
    it "Returns an array of dates for each night of the reservation" do
      dates = Hotel::Reservation.reservation_dates("April 1, 2019", "April 5, 2019")
      expect(dates).must_be_kind_of Array
      expect(dates.length).must_equal 4
    end
  end

  describe "nights" do
    it "Returns the number of nights for a reservation" do
      nights = Hotel::Reservation.num_nights("April 1, 2019", "April 5, 2019")
      expect(nights).must_equal 4
    end
  end

  describe "validate_dates" do
    it "Raises an error if one or both of the dates is in the past" do
      expect {
        Hotel::Reservation.validate_dates("April 1, 1999", "April 5, 2019")
      }.must_raise ArgumentError

      expect {
        Hotel::Reservation.validate_dates("April 1, 2019", "April 5, 1999")
      }.must_raise ArgumentError

      expect {
        Hotel::Reservation.validate_dates("April 1, 1999", "April 5, 1999")
      }.must_raise ArgumentError
    end

    it "Raises an error if the checkout date is before the checkin date" do
      expect {
        Hotel::Reservation.validate_dates("April 5, 2019", "April 1, 2019")
      }.must_raise ArgumentError
    end
  end

  describe "total_cost" do
    it "Returns the total cost for a reservation" do
      booking = Hotel::Booking.new
      booking.rooms = Hotel::Room.list_rooms(100, 20, 150)
      reservation = booking.request_reservation("April 1, 2019", "April 5, 2019")
      expect(reservation.total_cost).must_equal 600
    end
  end
end