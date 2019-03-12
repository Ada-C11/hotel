require_relative "spec_helper"

describe "ReservationDate class" do
  let(:valid_reservation) {
    Hotel::ReservationDate.new(check_in: "March 20, 2020", check_out: "March 27, 2020")
  }
  describe "ReservationDate#initialize" do
    it "is an instance of ReservationDate" do
      expect(valid_reservation).must_be_instance_of Hotel::ReservationDate
    end

    it "instance variable check_in is correct" do
      expect(valid_reservation).must_respond_to :check_in
      expect(valid_reservation.check_in).must_be_instance_of Date
      expect(valid_reservation.check_in).must_equal Date.new(2020, 03, 20)
    end

    it "instance variable check_out is correct" do
      expect(valid_reservation).must_respond_to :check_out
      expect(valid_reservation.check_out).must_be_instance_of Date
      expect(valid_reservation.check_out).must_equal Date.new(2020, 03, 27)
    end

    it "will raise exception if invalid date range used" do
      date1 = (Time.new + 172800).to_date.to_s
      date2 = (Time.new + 172800 * 4).to_date.to_s
      past = "march 2, 2019"
      expect { Hotel::ReservationDate.new(check_in: date2, check_out: date1) }.must_raise InvalidDateRangeError
      expect { Hotel::ReservationDate.new(check_in: past, check_out: date1) }.must_raise InvalidDateRangeError
    end
  end

  let(:date1) { (Time.new + 172800).to_date }
  let(:date2) { (Time.new + 172800 * 4).to_date }
  let(:past) { Date.new(2019, 02, 13) }
  describe "ReservationDate#valid_date_range?" do
    it "check_in is before check_out" do
      expect(valid_reservation.valid_date_range?(date1, date2)).must_equal true
    end

    it "check_in is same as end" do
      expect(valid_reservation.valid_date_range?(date2, date2)).must_equal false
    end

    it "check_in is before today" do
      expect(valid_reservation.valid_date_range?(past, date1)).must_equal false
    end
  end
end
