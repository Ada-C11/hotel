require_relative 'spec_helper'

describe "Booking" do
  describe "#initialize" do
    it "Is an instance of Booking" do
      booking = Hotel::Booking.new
      expect(booking).must_be_kind_of Hotel::Booking
    end
  end

  describe "request_reservation" do
    it "Returns an instance of Reservation" do
      booking = Hotel::Booking.new
      request = booking.request_reservation("April 1, 2019", "April 5, 2019")
      expect(request).must_be_kind_of Hotel::Reservation
    end
  end
end
