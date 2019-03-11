require_relative 'spec_helper'

describe "Room class" do

  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(
        room_number: 1, 
        rate: 200,
        status: :AVAILABLE
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end
end    
