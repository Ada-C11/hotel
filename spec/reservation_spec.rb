require_relative "spec_helper"
describe "Hotel::Reservation" do
  let (:room) {
    Hotel::Room.new(1)
  }
  let (:reservation) {
    reservation = Hotel::Reservation.new(reservation_id: 1, room: room, check_in_date: "2019-03-12", check_out_date: "2019-03-15")
  }

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "stores an instance of Room" do
      expect(room).must_be_kind_of Hotel::Room
    end

    it "check-in-date and check-out-date are instances of Date" do
      expect(reservation.check_in_date).must_be_kind_of Date
      expect(reservation.check_out_date).must_be_kind_of Date
    end

    it "raises an ArgumentError if the check-out-date is before the check-in-date" do
      expect { Hotel::Reservation.new(1, room, "2019-03-12", "2019-03-10") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if the check-in-date or the check-out-date is nil" do
      expect { Hotel::Reservation.new(1, room, nil, "2019-03-10") }.must_raise ArgumentError
      expect { Hotel::Reservation.new(1, room, "2019-03-10", nil) }.must_raise ArgumentError
    end
  end

  describe "cost" do
    it "calculates the total cost correctly" do
      expect(reservation.cost).must_be_close_to 600.0
    end
  end
end
