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
    before do 
      @booking.rooms = Hotel::Room.list_rooms(100, 20, 150)
      @request = @booking.request_reservation("April 1, 2019", "April 5, 2019")
    end
    it "Returns an instance of Reservation" do
      expect(@request).must_be_kind_of Hotel::Reservation
    end

    it "Associates a room with a Reservation" do
      expect(@request.room).must_be_kind_of Hotel::Room
    end
  end

  describe "check_availability" do
    it "Returns a room number" do
      @booking.rooms = Hotel::Room.list_rooms(100, 20, 150)
      request = @booking.check_availability(["2019-04-01", "2019-04-02", "2019-04-03", "2019-04-04"])
      expect(request).must_be_kind_of Hotel::Room
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
