require_relative "spec_helper.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/date_range.rb"
require_relative "../lib/hotel.rb"

describe "Reservation class" do 

    before do
        @dates = HotelSystem::DateRange.new(start_year: 2019, start_day: 1, start_month: 1, num_nights: 4)
        @reservation = HotelSystem::Reservation.new(id: 1, room_number: 1, date_range: @dates)
    end

    describe "reservation initalization" do

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

        it "has a DateRange for the dates" do
            expect(@reservation.date_range).must_be_kind_of HotelSystem::DateRange
        end
    end

    describe "cost method" do
        it "will return the correct cost for a non-block reservation" do
            expect(@reservation.cost).must_equal 800
        end

        it "will return the correct cost for a block reservation" do
            hotel = HotelSystem::Hotel.new(20)
            hotel.create_block(start_year: 2019, start_month: 1, start_day: 1, num_nights: 5, room_nums: [1, 2, 3], block_rate: 100)
            block_reservation = hotel.reserve_block_room(room_num: 3, block_id: 1)
            block_res = hotel.reservations[0]

            expect(block_res.cost).must_equal 500
        end
    end

end