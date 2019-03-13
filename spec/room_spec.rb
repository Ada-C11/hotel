require_relative "spec_helper.rb"
require_relative "../lib/room.rb"

describe "Room initalization" do
    before do
        @room = HotelSystem::Room.new(1)
    end

    it "creates an instance of Room" do
        expect(@room).must_be_kind_of HotelSystem::Room
    end

    it "has a room number" do
        expect(@room.room_number).must_equal 1
    end

    it "raises an ArgumentError for non-integer arguments" do
        expect{
            room = HotelSystem::Room.new(1.5)
        }.must_raise ArgumentError
    end

    it "raises an ArgumentError for arguments less than or equal to 0" do
        expect{
            room = HotelSystem::Room.new(0)
        }.must_raise ArgumentError
    end

    it "has an array of reservations" do
        expect(@room.reservations).must_be_kind_of Array
    end
end