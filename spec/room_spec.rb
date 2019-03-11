require_relative "spec_helper"

describe "Room Class" do
  describe "Initialize" do
    before do
      @room = Room.new(number: 3)
    end
    it "Is an instance of Room" do
      expect(@room).must_be_kind_of Room
    end

    it "Stores a room number" do
      expect(@room.number).must_equal 3
    end
  end
end
