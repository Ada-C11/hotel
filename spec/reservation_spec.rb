require_relative "spec_helper"

describe "Reservation class " do
  describe "Initializer" do
    let(:nights) { [Date.new(2001, 2, 3), Date.new(2001, 2, 4)] }
    let(:room) { Hotel::Room.new(room_number: 1) }
    let(:reservation) {
      reservation = Hotel::Reservation.new(room: room,
                                           nights: nights)
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

      expect(reservation.room.available?(night: nights.first)).must_equal true
      expect(reservation.room.available?(night: nights.last)).must_equal true
    end

    it "creates an array of booked nights" do
      expect(reservation.nights).must_be_kind_of Array
      expect(reservation.nights.length).must_equal 2

      reservation2 = Hotel::Reservation.new(room: room,
                                            nights: nights)

      expect(reservation2.nights.length).must_equal 2
      expect(reservation2.nights.first).must_equal Date.new(2001, 2, 3)
      expect(reservation2.nights.last).must_equal Date.new(2001, 2, 4)
    end
  end
end
