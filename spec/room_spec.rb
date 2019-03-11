require_relative "spec_helper"

describe "Room class" do
    before do
        @room = Hotel::Room.new(1)
    end
    
    describe "Instantiation of Room" do
        it "is an instance of Room class" do
    
        expect(@room).must_be_instance_of Hotel::Room
        end

        it "has a default status of :AVAILABLE" do

        expect(@room.status).must_equal :AVAILABLE
        end
    end
end