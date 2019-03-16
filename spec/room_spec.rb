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

    it "it loads 20 rooms with self.load_rooms" do
        all_rooms = Hotel::Room.load_rooms
        expect(all_rooms).must_be_kind_of Array
        expect(all_rooms[0]).must_be_kind_of Hotel::Room
        expect(all_rooms.length).must_equal 20
    end
  
end