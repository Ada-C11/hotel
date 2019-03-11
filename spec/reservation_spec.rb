require_relative "spec_helper"

describe "Reservation class" do
  let(:valid_reservation) {
    Hotel::Reservation.new(start_date: "March 20, 2020", end_date: "March 27, 2020")
  }
  describe "Reservation#initialize" do
    it "is an instance of Reservation" do
      expect(valid_reservation).must_be_instance_of Hotel::Reservation
    end

    it "instance variable start_date is correct" do
      expect(valid_reservation).must_respond_to :start_date
      expect(valid_reservation.start_date).must_be_instance_of Date
      expect(valid_reservation.start_date).must_equal Date.new(2020, 03, 20)
    end

    it "instance variable end_date is correct" do
      expect(valid_reservation).must_respond_to :end_date
      expect(valid_reservation.end_date).must_be_instance_of Date
      expect(valid_reservation.end_date).must_equal Date.new(2020, 03, 27)
    end
  end

  let(:valid_start_date) {
    valid_reservation.start_date
  }
  let(:valid_end_date) {
    valid_reservation.end_date
  }
  describe "dates are valid" do
    it "start_date is before end_date" do
      expect(valid_date_range?(valid_start_date, valid_end_date)).must_equal true
    end
  end
end
