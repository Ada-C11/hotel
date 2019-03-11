require_relative "spec_helper"

describe "Room class" do
    describe "Room instantiation" do
        before do
            @room = HotelManagementSystem::Room.new(
              room_number: 4,
            )
        end

        it "throws an argument error with an invalid room number" do
            expect { HotelManagementSystem::Room.new(room_number: 21, status: :AVAILABLE) }.must_raise ArgumentError
            expect { HotelManagementSystem::Room.new(room_number: 0, status: :AVAILABLE) }.must_raise ArgumentError
        end

        # it "has a default status of :AVAILABLE" do
        #     expect {@room.status}.must_equal :AVAILABLE
        # end





        it "has a room number" do
        end

        it "has a status" do
        end

        it "can be assigned a guest" do
        end

        it "has a cost" do
        end
    end
end
