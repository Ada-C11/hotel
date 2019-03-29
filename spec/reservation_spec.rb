require_relative "spec_helper"
describe "Hotel::Reservation" do
  let (:room) {
    Hotel::Room.new(1)
  }
  let (:reservation) {
    reservation = Hotel::Reservation.new(reservation_id: 1, check_in_date: "2019-03-12", check_out_date: "2019-03-15", room_id: 1)
  }

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(reservation).must_be_instance_of Hotel::Reservation
    end

    it "has room_id as an integer" do
      expect(reservation.room_id).must_be_kind_of Integer
    end

    it "check-in-date and check-out-date are instances of Date" do
      expect(reservation.check_in_date).must_be_kind_of Date
      expect(reservation.check_out_date).must_be_kind_of Date
    end

    it "raises an ArgumentError if room_id is not provided" do
      expect { Hotel::Reservation.new(check_in_date: "2019-03-12", check_out_date: "2019-03-15") }.must_raise ArgumentError
    end
  end
end
