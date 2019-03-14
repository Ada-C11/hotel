require_relative "spec_helper"

describe "Reservation Class" do
  describe "Initialize" do
    let (:reservation) {
      Hotel::Reservation.new(
        check_in_date: "2018-03-09",
        check_out_date: "2018-03-12",
        room_number: 2,
      )
    }

    it "Is an instance of Reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Stores a room number" do
      expect(reservation.room_number).must_equal 2
    end

    it "Stores a range of dates" do
      ["2018-03-09", "2018-03-10", "2018-03-11"].each do |date|
        expect(reservation.all_dates).must_include Date.parse(date)
      end
    end

    it "Raises an ArgumentError for invalid check-out date" do
      reservation = {
        check_in_date: "2018-03-09",
        check_out_date: "2018-03-08",
        room_number: 2,
      }

      expect {
        Hotel::Reservation.new(reservation)
      }.must_raise ArgumentError
    end
  end

  describe "#total_cost" do
    let (:reservation) {
      Hotel::Reservation.new(
        check_in_date: "2018-03-09",
        check_out_date: "2018-03-12",
        room_number: 2,
      )
    }

    it "must return a float" do
      expect(reservation.total_cost).must_be_kind_of Float
    end

    it "returns the correct total for a multi-day reservation" do
      expect(reservation.total_cost).must_equal (3 * 200.0)
    end

    it "returns the correct total for a single day reservation" do
      reservation = Hotel::Reservation.new(
        check_in_date: "2018-03-09",
        check_out_date: "2018-03-09",
        room_number: 2,
      )
      expect(reservation.total_cost).must_equal (1 * 200.0)
    end
  end
end
