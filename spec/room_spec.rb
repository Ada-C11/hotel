require_relative 'spec_helper'

describe "Room class" do

  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(
        room_number: 1, 
        rate: 200,
        status: :AVAILABLE,
        reservations: nil
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
    
    it "has a default status of Available" do
      expect(Hotel::Room.new(room_number: 2, rate: 200).status).must_equal :AVAILABLE
    end
    
      
    it "throws an argument error with an invalid room number" do
      expect { Hotel::Room.new(id: 0, rate: 200, status: :AVAILABLE) }.must_raise ArgumentError
    end
      
    it "sets reservations to an empty array if no reservations have occurred" do
      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations.length).must_equal 0
    end
    
    
      
  end
end    
