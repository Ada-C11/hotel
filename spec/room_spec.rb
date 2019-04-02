require_relative "spec_helper"

describe "Room" do

    describe "add_reservation" do
        before do
            @room = Hotel::Room.new(2, 200)
            reservation = Hotel::Reservation.new(Date.parse("20190310"), Date.parse("20190313"), @room)
            @reservation_in_array = @room.reservations.length
        end

        it "adds an instance of reservation to the reservations array" do
            @reservation2 = Hotel::Reservation.new(Date.parse("2019020"), Date.parse("20190325"), @room)
            expect(@room.reservations.length).must_equal @reservation_in_array + 1
        end
    end
end