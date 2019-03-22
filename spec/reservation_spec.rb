require "minitest/autorun"

describe Reservation do 
    it "can assign a room to a date range" do 
        reservation = Reservation.new
        reservation.must_equal true 
    end
end

describe "new reservation" do
    before do

    @reservation = Hotel::Reservation.new("Leslie Knope", "2019-01-01")
    end

      checkin_date = Date.parse("2019-01-01")
      reservation = Hotel::Reservation.new("Leslie Knope", checkin_date.to_s)
      @room = Hotel::Room.new(1)
      @room.add_reservation(reservation)
    end

    it "adds reserved dates" do
      expect(@room.availability).must_be_kind_of Array
    end

    it "creates a reservation" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end
    it "calculates the checkout date" do
      expect(@reservation.checkout_date.to_s).must_equal "2019-01-02"
    end
    it "raises an ArgumentError for invalid date entry" do
      expect { Hotel::Reservation.new("Leslie Knope", "2019-02-02") }.must_raise ArgumentError
    end
  end