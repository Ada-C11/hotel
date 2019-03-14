require_relative "spec_helper"

describe "Reservation Class" do
    let(:reservation) {Hotel::Reservation.new(id: 2, date_range: [1,2], room: 1)}

    it "is an instance of Reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "calculates the cost of a reservation" do
        expect(reservation.cost).must_be_kind_of Float
        expect(reservation.cost).must_equal 400.0
    end

end