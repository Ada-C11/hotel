require_relative "spec_helper"

describe "Room Class" do
    
    it "is an instance of Room" do
        room = Hotel::Room.new(1)
        expect(room).must_be_kind_of Hotel::Room
    end
  
end