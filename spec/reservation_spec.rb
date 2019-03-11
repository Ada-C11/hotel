require_relative "spec_helper"

describe "Reservation Class" do
  describe "Initialize" do
    before do
      @reservation = Reservation.new(
        check_in_date: "09-03-2018",
        check_out_date: "10-03-2018",
        room_number: 2,
      )
    end

    it "Is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "Stores a room number" do
      expect(@reservation.room_number).must_equal 2
    end
  end
end
