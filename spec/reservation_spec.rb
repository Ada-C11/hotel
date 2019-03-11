require_relative "spec_helper"

describe "Reservation Class" do
  describe "Initialize" do
    let (:reservation) {
      Reservation.new(
        check_in_date: "2018-03-09",
        check_out_date: "2018-03-10",
        room_number: 2,
      )
    }

    it "Is an instance of Reservation" do
      expect(reservation).must_be_kind_of Reservation
    end

    it "Stores a room number" do
      expect(reservation.room_number).must_equal 2
    end

    it "Raises an ArgumentError for invalid check-out date" do
      reservation = {
        check_in_date: "2018-03-09",
        check_out_date: "2018-03-08",
        room_number: 2,
      }

      expect {
        Reservation.new(reservation)
      }.must_raise ArgumentError
    end
  end
end
