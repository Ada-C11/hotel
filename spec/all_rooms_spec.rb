require_relative "spec_helper"

describe "AllRooms class" do
    before do
        @all_rooms = Hotel::AllRooms.new
    end

    it "initializes an array of rooms" do
        expect(@all_rooms.all_rooms).must_be_kind_of Array
        expect(@all_rooms.all_rooms.length).must_equal 20

    end

    it "instantiates AllRooms class" do
        expect(@all_rooms).must_be_kind_of Hotel::AllRooms
    end

    it "get_room returns an instance of room" do
       expect(@all_rooms.get_room).must_be_kind_of Hotel::Room
    end  

    describe "list_all_rooms" do
        it "returns an array of room instances" do
            expect(@all_rooms.list_all_rooms).must_be_instance_of Array
            expect(@all_rooms.list_all_rooms[2]).must_be_kind_of Hotel::Room
        end
    end

    describe "rooms_not_reserved" do
        it "returns an array of room instances" do
            expect(@all_rooms.rooms_not_reserved(Date.parse("20190314"), Date.parse("20190318"))).must_be_instance_of Array
            rooms = @all_rooms.rooms_not_reserved(Date.parse("20190316"), Date.parse("20190318"))
            expect(rooms[0]).must_be_kind_of Hotel::Room

        end

        it "returns available rooms" do

        end
    end


end