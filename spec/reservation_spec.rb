require_relative "spec_helper"

describe "Reservation class" do
  describe "Reservation#initialize" do
    let(:valid_reservation) {
      Hotel::Reservation.new(start_date: "March 20, 2020", end_date: "March 27, 2020")
    }
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
end
