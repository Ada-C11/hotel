require_relative "spec_helper"

describe "Reservation class " do
  describe "Initalizer" do
    let(:start_date) { Date.new(2001, 2, 3) }
    let(:end_date) { Date.new(2001, 2, 5) }
    let(:room) { Hotel::Room.new(1) }
    let(:reservation) {
      reservation = Hotel::Reservation.new(start_date, end_date, room)
    }

    it "is able to instantiate" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "correctly extracts nights needed from days given" do
      days = end_date - start_date
      nights = reservation.last_night - reservation.first_night
      expect(days - nights).must_equal 1
      expect(end_date).must_equal Date.new(2001, 2, 5)
      expect(start_date).must_equal reservation.first_night
      expect(reservation.last_night).must_equal Date.new(2001, 2, 4)
    end

    it "calculates length of stay" do
      expect(reservation.length_of_stay).must_equal 2
    end

    it "calculates cost of reservation" do
      expect(reservation.cost).must_equal 400
    end

    it "assigns available room" do
      expect(reservation.room).must_be_kind_of Hotel::Room
      expect(reservation.room.available?).must_equal true
      expect(reservation.room.status).must_equal :AVAILABLE
    end

    it "creates an array of booked dates" do
      expect(reservation.dates).must_be_kind_of Array
      expect(reservation.dates.length).must_equal 2
      reservation2 = Hotel::Reservation.new(Date.new(2018, 7, 10), Date.new(2018, 7, 20), room)
      expect(reservation2.dates.length).must_equal 10
      expect(reservation2.dates.first).must_equal Date.new(2018, 7, 10)
      expect(reservation2.dates.last).must_equal Date.new(2018, 7, 19)
    end
  end
end
