require_relative "spec_helper"

describe "Reservation" do
    before do
        @room = Hotel::Room.new(2, 200)
        @reservation = Hotel::Reservation.new(Date.parse("20190310"), Date.parse("20190315"), @room)
    end
   
    it "instantiates Reservation class" do
        expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "adds the reservation to room when initializing" do
        @room = Hotel::Room.new(2, 200)
        reservation = Hotel::Reservation.new(Date.parse("20190312"), Date.parse("20190315"), @room)
        @reservation_in_array = @room.reservations.length
        @reservation2 = Hotel::Reservation.new(Date.parse("2019022"), Date.parse("20190325"), @room)
        expect(@room.reservations.length).must_equal @reservation_in_array + 1
    end

    it "returns accurate length of stay" do
        expect(@reservation.length_of_stay).must_equal 5
    end

    it "returns accurate total cost" do
        expect(@reservation.total_cost).must_equal 1000
    end
end
