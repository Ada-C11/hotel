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

  let(:date1) {
    Date.new(2020, 03, 20)
  }
  let(:date2) {
    Date.new(2020, 03, 24)
  }
  let(:past) {
    Date.new(2019, 02, 13)
  }
  describe "Reservation#valid_date_range?" do
    it "start_date is before end_date" do
      expect(valid_reservation.valid_date_range?(date1, date2)).must_equal true
    end

    it "start_date is same as end" do
      expect(valid_reservation.valid_date_range?(date2, date2)).must_equal false
    end

    it "start_date is before today" do
      expect(valid_reservation.valid_date_range?(past, date1)).must_equal false
    end
  end
end
