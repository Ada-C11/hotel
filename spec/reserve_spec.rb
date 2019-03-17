require_relative "spec_helper"

describe "Reserve" do
  first_day = Date.parse("March 1st 2025")
  last_day = Date.parse("March 3rd 2025")
  let(:reservy) { Reservation.new(id: 1, room_booked: 3, dates_booked: (first_day..last_day)) }

  describe "initialize" do
    it "knows reserve is an instance of Reservation" do
      expect(reservy).must_be_kind_of Reservation
    end

    it "knows the reservation id" do
      expect(reservy).must_respond_to :id
      expect(reservy.id).must_equal 1
    end

    it "validates that an id is an integer" do
      expect (reservy.valid_id(1)).must_equal true
    end

    it "raises exception for invalid id" do
      expect {
        reservy.valid_id("b")
      }.must_raise ArgumentError
    end

    it "raises exception upon instantiation for an id that is invalid" do
      expect {
        Reservation.new(id: "b")
      }.must_raise ArgumentError
    end

    it "calculates total cost for dates booked" do
      reservy.total_cost.must_equal 400.00
    end
  end
end
