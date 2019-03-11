require_relative "spec_helper.rb"
require_relative "../lib/reservation.rb"

describe "reservation initalization" do
    before do
        @reservation = HotelSystem::Reservation.new(room_number: 1)
    end

    it "creates an instance of Room" do
        expect(@reservation).must_be_kind_of HotelSystem::Reservation
    end

    it "has a room number" do
        expect(@reservation.room_number).must_equal 1
    end

    it "raises an ArgumentError if neither a room nor a room number are provided" do
        expect{
            room = HotelSystem::Reservation.new("cat")
        }.must_raise ArgumentError
    end

    it "raises an ArgumentError for invalid room numbers" do
        expect{
            room = HotelSystem::Reservation.new(room_number: 0)
        }.must_raise ArgumentError
    end

    it "raises an ArgumentError for invalid room arguments" do
        expect{
            room = HotelSystem::Reservation.new(room: "cat")
        }.must_raise ArgumentError
    end

    it "has an array for the dates" do
        expect(@reservation.dates).must_be_kind_of Array
    end
end