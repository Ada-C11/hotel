require_relative "spec_helper"

describe "Reservation" do
    describe "ArgumentErrors are raised" do
        it "raises ArgumentError if dates are invalid" do
            expect{ HotelManagementSystem::Reservation.new(
                start_date: '15th Mar 2019', end_date: '11th Mar 2019', room: 2) }.must_raise ArgumentError
        end

        it "raises ArgumentError if room is not provided" do
            expect{ HotelManagementSystem::Reservation.new(
                start_date: '11th Mar 2019', end_date: '15th Mar 2019') }.must_raise ArgumentError
        end
    end

    describe "Reservation instantiation" do
        before do
            @reservation = HotelManagementSystem::Reservation.new(
                start_date: '11th Mar 2019', 
                end_date: '15th Mar 2019', 
                room: HotelManagementSystem::Room.new(room: 12))
        end

        it "must be instance of Reservation" do
            expect(@reservation).must_be_kind_of HotelManagementSystem::Reservation
        end

        it "provides the duration of a reservation" do
            expect(@reservation.duration).must_equal 4
        end

        it "give the total cost of a reservation" do
            expect(@reservation.total_cost).must_equal 800
        end
    end
end

