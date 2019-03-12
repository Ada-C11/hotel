require_relative 'spec_helper'

describe "Booking" do
  before do
    @booking = Hotel::Booking.new
  end
  describe "#initialize" do
    it "Is an instance of Booking" do
      expect(@booking).must_be_kind_of Hotel::Booking
    end
  end

  describe "request_reservation" do
    it "Returns an instance of Reservation" do
      request = @booking.request_reservation("April 1, 2019", "April 5, 2019")
      expect(request).must_be_kind_of Hotel::Reservation
    end
  end

  describe "find_reservation" do
    it "Returns a collection of Reservations for a specific date" do
      @booking.request_reservation("April 1, 2019", "April 5, 2019")
      @booking.request_reservation("April 3, 2019", "April 5, 2019")
      res_date = @booking.find_reservation("April 3, 2019")
      expect(res_date).must_be_kind_of Array
      expect(res_date.first).must_be_kind_of Hotel::Reservation
      expect(res_date.length).must_equal 2
    end
  end
end
