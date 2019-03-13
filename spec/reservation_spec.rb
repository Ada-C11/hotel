require_relative "spec_helper"

describe "Reservation class " do
  describe "Initalizer" do
    let(:start_date) { Date.new(2001, 2, 3) }
    let(:end_date) { Date.new(2001, 2, 5) }
    let(:dates) { [Date.new(2001, 2, 3), Date.new(2001, 2, 4)] }
    let(:room) { Hotel::Room.new(room_number: 1) }
    let(:reservation) {
      reservation = Hotel::Reservation.new(room: room,
                                           dates: dates)
    }

    it "is able to instantiate" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "calculates length of stay" do
      expect(reservation.length_of_stay).must_equal 2
    end

    it "calculates cost of reservation" do
      expect(reservation.cost).must_equal 400
    end

    it "assigns room" do # used to check if it assigned available room
      expect(reservation.room).must_be_kind_of Hotel::Room
      # expect(reservation.room.available?).must_equal true
    end

    it "creates an array of booked dates" do
      expect(reservation.dates).must_be_kind_of Array
      expect(reservation.dates.length).must_equal 2

      reservation2 = Hotel::Reservation.new(room: room,
                                            dates: dates)

      expect(reservation2.dates.length).must_equal 2
      expect(reservation2.dates.first).must_equal Date.new(2001, 2, 3)
      expect(reservation2.dates.last).must_equal Date.new(2001, 2, 4)
    end
  end
end
