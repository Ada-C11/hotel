require_relative "spec_helper"

describe "Reservation class" do
  let(:valid_reservation) {
    Hotel::Reservation.new(check_in: Date.parse("March 20, 2020"), check_out: Date.parse("March 27, 2020"))
  }
  describe "Reservation#initialize" do
    it "is an instance of Reservation" do
      expect(valid_reservation).must_be_instance_of Hotel::Reservation
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
      date1 = (Time.new + 172800).to_date
      date2 = (Time.new + 172800 * 4).to_date
      past = Date.parse("march 2, 2019")
      expect { Hotel::Reservation.new(check_in: date2, check_out: date1) }.must_raise InvalidDateRangeError
      expect { Hotel::Reservation.new(check_in: past, check_out: date1) }.must_raise InvalidDateRangeError
    end
  end

  let(:date1) { (Time.new + 172800).to_date }
  let(:date2) { (Time.new + 172800 * 4).to_date }
  let(:past) { Date.new(2019, 02, 13) }
  describe "Reservation#valid_date_range?" do
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
