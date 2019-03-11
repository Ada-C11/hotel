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

    it "has a cost of 200 per night" do
        expect(@room.cost_per_night).must_equal 200
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
end