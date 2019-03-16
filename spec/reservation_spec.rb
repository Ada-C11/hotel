require_relative "spec_helper"

describe "Reservation Class" do
    let(:reservation) {Hotel::Reservation.new(id: 2, date_range: [1,2], room: 1)}

    it "is an instance of Reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
      expect(reservation.id).must_equal 2
      expect(reservation.room).must_equal 1
    end

    it "calculates the cost of a reservation" do
        expect(reservation.cost).must_be_kind_of Float
        expect(reservation.cost).must_equal 400.0
    end

    it "calculates the cost of reservation with 4 nights" do
        test = Hotel::Reservation.new(id: 2, date_range: [1,2,3,4], room: 1)
        expect(test.cost).must_be_kind_of Float
        expect(test.cost).must_equal 800.0
    end

    it "calculates the cost of empty array date range given" do
        test = Hotel::Reservation.new(id: 2, date_range: [], room: 1)
        expect(test.cost).must_be_kind_of Float
        expect(test.cost).must_equal 0
    end

end