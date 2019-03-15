require_relative "spec_helper"

describe "Reserve" do
  let(:res) {
    Reservation.new(check_in: "March 2nd, 2020", check_out: "March 5th, 2020")
  }
  let(:check_in) {
    "March 2nd, 2020"
  }
  let(:check_out) {
    "March 5th, 2020"
  }
  let(:bogus) {
    "March 88th, 2020"
  }
  let(:past) {
    "March 1st, 2019"
  }

  describe "the date_range_methods" do
    it "must accurately record check-in date" do
      expect(res.check_in).must_equal Date.parse("2020-03-02")
    end

    it "can validate that a check-in date occurs before check-out" do
      expect(res.date_range_valid?(check_in, check_out)).must_equal true
    end

    it "raises an exception for an invalid check-in day" do
      expect {
        res.valid_date?(bogus)
      }.must_raise ArgumentError
    end
  
    it "raises an exceptions for past dates upon init of a new reservation" do
      expect{
          res.valid_date?(past)
      }.must_raise ArgumentError
    end
  end

  describe "Reserve" do
    before do
      @reserved = Reservation.new(id: 1,
                                  check_in: "2020-03-03",
                                  check_out: "2020-05-03",
                                  room_booked: 1,
                                  total_cost: 400.00)
    end
    describe "initialize" do
      it "knows reserve is an instance of Reservation" do
        expect(@reserved).must_be_kind_of Reservation
      end

      it "knows the reservation id" do
        expect(@reserved).must_respond_to :id
        expect(@reserved.id).must_equal 1
      end
    end
  end
end