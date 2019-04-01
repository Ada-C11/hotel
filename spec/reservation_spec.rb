require_relative "spec_helper"
require "date"
require "pry"

describe "Reservation class" do
  let (:reservation) do
    Hotel::Reservation.new("1 Jan 2021", "2 Jan 2022")
  end

  describe "initialize" do
    it "Creates an instance of reservation" do
      expect(reservation).must_be_instance_of Hotel::Reservation
    end
    it "Reservation class initialized with a start date" do
      expect(reservation.start_date).must_equal "1 Jan 2021"
    end
  end
  describe "duration method" do
    it "Returns the length of time between 2 dates" do
      reservation = Hotel::Reservation.new("1st Mar 2020", "8th Mar 2020")
      expect(reservation.duration).must_equal 7
    end
    it "Raises an ArgumentError if the end date is before the start date" do
      reservation = Hotel::Reservation.new("7th Mar 2020", "6th Mar 2020")
      expect { reservation.duration }.must_raise ArgumentError
    end
    it "Raises an ArgumentError if the trip starts and ends on the same date" do
      reservation = Hotel::Reservation.new("7th Mar 2020", "7th Mar 2020")
      expect { reservation.duration }.must_raise ArgumentError
    end
    it "Raises an ArgumentError if the start date is in the past" do
      reservation = Hotel::Reservation.new("7th Feb 2019", "8th Feb 2019")
      expect { reservation.duration }.must_raise ArgumentError
    end
    it "Can calulate duration that spans multiple months" do
      reservation = Hotel::Reservation.new("30th Jan 2020", "6th Feb 2020")
      expect(reservation.duration).must_equal 7
    end
  end

  describe "reservation_dates method" do
    it "Creates an array of arrays of the dates included in a reservation" do
      reservation = Hotel::Reservation.new("1st Mar 2020", "3rd Mar 2020")
      expect(reservation.reservation_dates).must_equal [Date.parse("1st Mar 2020"), Date.parse("2nd Mar 2020"), Date.parse("3rd Mar 2020")]
    end
  end

  describe "total_cost method" do
    it "Calculates the cost of stay" do
      reservation = Hotel::Reservation.new("1st Mar 2020", "8th Mar 2020")
      expect(reservation.total_cost).must_equal 1400
    end
    it "Calculates the cost of the stay based on the room price" do
      reservation = Hotel::Reservation.new("1st Mar 2020", "8th Mar 2020", cost: 100)
      expect(reservation.total_cost).must_equal 700
    end
  end
end
