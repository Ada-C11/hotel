require_relative "spec_helper.rb"
require_relative "../lib/room.rb"

describe "Room class" do
    before do
        @room = HotelSystem::Room.new(1)
    end

    describe "Room initalization" do

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

    describe "add_block_date_ranges method" do

        it "will raise an error for bad input" do
            expect{
                @room.add_block_date_ranges("cat")
            }.must_raise ArgumentError
        end
    end

    describe "in_block? method" do
        it "will raise an ArgumentError for bad input" do
            expect {
                @room.in_block?(year: 2019, month: 2, day: 30)
            }.must_raise ArgumentError
        end
    end

end