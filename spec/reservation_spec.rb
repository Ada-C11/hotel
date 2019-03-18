require_relative "spec_helper"
require "date"
require "pry"

describe "Reservation class" do
  let (:reservation) do
    Hotel::Reservation.new
  end

  describe "initialize" do
    it "Creates an instance of reservation" do
      expect(reservation).must_be_instance_of Hotel::Reservation
    end
    it "Reservation class initialized with todays date as a  start  date if no date is given" do
      expect(reservation.start_date).must_equal Date.today.to_s
    end
    it "Reservation class initialized with tomorrow as end date if no date is given" do
      expect(reservation.end_date).must_equal (Date.today + 1).to_s
    end
  end
  describe "duration_length method" do
    it "Duration returns the length of time between 2 dates" do
      reservation = Hotel::Reservation.new(start_date: "1st Mar 2020", end_date: "8th Mar 2020")
      expect(reservation.duration).must_equal 7
    end
    it "Raises an ArgumentError if the duration is less than 1 day" do
      reservation = Hotel::Reservation.new(start_date: "7th Mar 2020", end_date: "6th Mar 2020")
      expect { reservation.duration }.must_raise ArgumentError
    end
    it "Raises an ArgumentError if the start date is in the past" do
      reservation = Hotel::Reservation.new(start_date: "7th Feb 2019", end_date: "8th Feb 2019")
      expect { reservation.duration }.must_raise ArgumentError
    end

    it "Can calulate duration that spans multiple months" do
      reservation = Hotel::Reservation.new(start_date: "31st Jan 2020", end_date: "7th Feb 2020")
      expect(reservation.duration).must_equal 7
    end
  end
  describe "reservation_dates method" do
    it "creates an array of arrays of the dates included in a reservation" do
      reservation = Hotel::Reservation.new(start_date: "1st Mar 2020", end_date: "3rd Mar 2020")
      expect(reservation.reservation_dates).must_equal [Date.parse("1st Mar 2020"), Date.parse("2nd Mar 2020"), Date.parse("3rd Mar 2020")]
    end
  end

  describe "total_cost method" do
    it "Can calcute cost of stay" do
      reservation = Hotel::Reservation.new(start_date: "1st Mar 2020", end_date: "8th Mar 2020")
      expect(reservation.total_cost).must_equal 1400
    end
  end
end
