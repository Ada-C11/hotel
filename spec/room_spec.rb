require_relative "spec_helper"

describe "Room" do
    describe "Room instantiation" do
        before do
            @room = HotelManagementSystem::Room.new(room: 4)
        end

        it "creates an instance of a room" do
            expect (@room).must_be_kind_of HotelManagementSystem::Room
        end

        it "throws an argument error with an invalid room number" do
            expect { HotelManagementSystem::Room.new(room: 21) }.must_raise ArgumentError
            expect { HotelManagementSystem::Room.new(room: 0) }.must_raise ArgumentError
        end

        it "has a room number" do
            expect(@room.room).must_equal 4
        end
    end

    describe "Room reservations" do
        before do
            @room = HotelManagementSystem::Room.new(room: 4)
            @reservation1 = HotelManagementSystem::Reservation.new(
                start_date: '11th Mar 2019', 
                end_date: '15th Mar 2019', 
                room: HotelManagementSystem::Room.new(room: 4))
            @reservation2 = HotelManagementSystem::Reservation.new(
                start_date: '18th Mar 2019', 
                end_date: '25th Mar 2019', 
                room: HotelManagementSystem::Room.new(room: 4))
        end

        it "lists own reservations" do
            @room.add_reservation(@reservation1)
            expect(@room.reservations).must_be_kind_of Array 
        end

        it "can add a reservation to own reservations" do
            before_adding = @room.reservations.length
            @room.add_reservation(@reservation1)
            after_adding1 = @room.reservations.length
            @room.add_reservation(@reservation2)
            after_adding2 = @room.reservations.length
            expect(after_adding2 - before_adding).must_equal 2
        end
    end
end
