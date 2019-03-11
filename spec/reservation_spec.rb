require_relative "spec_helper"

describe "Reservation class " do
  describe "Initalizer" do
    let(:start_date) { Date.new(2001, 2, 3) }
    let(:end_date) { Date.new(2001, 2, 5) }
    let(:reservation) {
      reservation = Reservation.new(start_date, end_date)
    }
    it "is able to instantiate" do
      expect(reservation).must_be_kind_of Reservation
    end

    it "correctly extracts nights needed from days given" do
      days = end_date - start_date
      nights = reservation.last_night - reservation.first_night
      expect(days - nights).must_equal 1
      expect(end_date).must_equal Date.new(2001, 2, 5)
      expect(start_date).must_equal reservation.first_night
      expect(reservation.last_night).must_equal Date.new(2001, 2, 4)
    end
  end
end
