require_relative 'spec_helper'

describe "Room class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(
        room_num: 15
      )
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "throws an ArgumentError for the room number greater than 20" do
      expect{Hotel::Room.new( room_num: 21, cost_per_night: 200)}.must_raise ArgumentError
    end

    it "throws an ArgumentError for the room number less than 1" do
      expect{Hotel::Room.new( room_num: 0, cost_per_night: 200)}.must_raise ArgumentError
    end

   

  end
end 