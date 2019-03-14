require_relative "spec_helper"

describe "Room Class" do

    it "is an instance of Room" do
        room = Hotel::Room.new(id: 1)
        expect(room).must_be_kind_of Hotel::Room
    end

    it "it accurately relays availabillity" do
        room = Hotel::Room.new(id: 1)
        room.reservations = [Hotel::Reservation.new(id: 1, date_range: [20190314], room: room)]
        expect(room.available?(20190313)).must_equal true
    end
  
end