require_relative "spec_helper"
describe "Hotel::Reservation" do
  let (:room) {
    Hotel::Room.new(1)
  }
  #   let (:reservation) {
  #     Hotel::Reservation.new(room, "2019-03-12", "2019-03-15")
  #   }
  describe "initialize" do
    it "is an instance of Reservation" do
      reservation = Hotel::Reservation.new(1, room, "2019-03-12", "2019-03-15")
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "stores an instance of Room" do
      expect(room).must_be_kind_of Hotel::Room
    end

    it "check-in-date and check-out-date are instances of Date" do
      reservation = Hotel::Reservation.new(1, room, "2019-03-12", "2019-03-15")
      expect(reservation.check_in_date).must_be_kind_of Date
      expect(reservation.check_out_date).must_be_kind_of Date
    end

    it "raises an ArgumentError if the check-out-date is before the check-in-date" do
      expect { Hotel::Reservation.new(1, room, "2019-03-12", "2019-03-10") }.must_raise ArgumentError
    end
  end
end
